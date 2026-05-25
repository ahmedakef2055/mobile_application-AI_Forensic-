import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import '../../core/theme/app_colors.dart';
import '../../providers/settings_provider.dart';
import 'security_dashboard_home_page_new.dart';
import '../incidents/incidents_page.dart';
import '../alerts/alerts_page.dart';
import '../profile/profile_page.dart';
import '../settings/settings_page.dart';

class HomeNavigationWrapper extends ConsumerStatefulWidget {
  const HomeNavigationWrapper({Key? key}) : super(key: key);
  static const routePath = '/dashboard-home';

  @override
  ConsumerState<HomeNavigationWrapper> createState() =>
      _HomeNavigationWrapperState();
}

class _HomeNavigationWrapperState
    extends ConsumerState<HomeNavigationWrapper> {
  int _selectedIndex = 4;
  late Offset _dragStartPos;

  final List<Widget> _pages = const [
    IncidentsPage(),           // index 0
    AlertsPage(),              // index 1
    ProfilePage(),             // index 2
    SettingsPage(),            // index 3
    SecurityDashboardHomePage(), // index 4 (home)
  ];

  void _handleSwipe(DragEndDetails details) {
    const double _swipeThreshold = 100.0;
    const double _velocityThreshold = 300.0;

    final double dx = details.velocity.pixelsPerSecond.dx;

    // السحب نحو اليمين (صفحة سابقة) أو السحب نحو اليسار (صفحة لاحقة)
    if (dx.abs() > _velocityThreshold) {
      if (dx > 0) {
        // سحب يمين → الصفحة السابقة
        if (_selectedIndex > 0) {
          setState(() => _selectedIndex--);
        }
      } else {
        // سحب شمال → الصفحة التالية
        if (_selectedIndex < _pages.length - 1) {
          setState(() => _selectedIndex++);
        }
      }
    }
  }

  static const _navKeys = [
    'nav.home',
    'nav.incidents',
    'nav.alerts',
    'nav.profile',
    'nav.settings',
  ];

  static const _icons = [
    [Icons.dashboard_outlined, Icons.dashboard_rounded],
    [Icons.shield_outlined, Icons.shield_rounded],
    [Icons.notifications_none_rounded, Icons.notifications_rounded],
    [Icons.person_outline_rounded, Icons.person_rounded],
    [Icons.settings_outlined, Icons.settings_rounded],
  ];

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final palette = c(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: palette.background,
        extendBody: true,
        body: GestureDetector(
          onHorizontalDragStart: (details) => _dragStartPos = details.globalPosition,
          onHorizontalDragEnd: _handleSwipe,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 450),
            reverseDuration: const Duration(milliseconds: 350),
            transitionBuilder: (child, animation) => _PageTransition(
              animation: animation,
              child: child,
            ),
            child: KeyedSubtree(
              key: ValueKey<int>(_selectedIndex),
              child: _pages[_selectedIndex],
            ),
          ),
        ),
        bottomNavigationBar: _ModernBottomNav(
          selectedIndex: _selectedIndex,
          onIndexChanged: (index) => setState(() => _selectedIndex = index),
          settings: settings,
          palette: palette,
        ),
      ),
    );
  }
}

class _PageTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const _PageTransition({
    required this.animation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.1, 0.0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
        ),
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.95, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _ModernBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onIndexChanged;
  final AppSettings settings;
  final AppPalette palette;

  const _ModernBottomNav({
    required this.selectedIndex,
    required this.onIndexChanged,
    required this.settings,
    required this.palette,
  });

  static const _navKeys = [
    'nav.incidents',
    'nav.alerts',
    'nav.profile',
    'nav.settings',
  ];

  static const _icons = [
    [Icons.shield_outlined, Icons.shield_rounded],
    [Icons.notifications_none_rounded, Icons.notifications_rounded],
    [Icons.person_outline_rounded, Icons.person_rounded],
    [Icons.settings_outlined, Icons.settings_rounded],
  ];

  @override
  Widget build(BuildContext context) {
    String t(String k) => AppStrings.get(k, settings.locale);

    return Container(
      decoration: BoxDecoration(
        color: palette.bgTop,
        border: Border(top: BorderSide(color: palette.border)),
        boxShadow: [
          BoxShadow(
            color: palette.shadow.withValues(alpha: 0.15),
            blurRadius: 24,
            offset: const Offset(0, -8),
            spreadRadius: 2,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side items (2)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _NavItemSmall(
                      index: 0,
                      isSelected: selectedIndex == 0,
                      label: t(_navKeys[0]),
                      icon: _icons[0][0],
                      activeIcon: _icons[0][1],
                      palette: palette,
                      onTap: () => onIndexChanged(0),
                    ),
                    _NavItemSmall(
                      index: 1,
                      isSelected: selectedIndex == 1,
                      label: t(_navKeys[1]),
                      icon: _icons[1][0],
                      activeIcon: _icons[1][1],
                      palette: palette,
                      onTap: () => onIndexChanged(1),
                    ),
                  ],
                ),
              ),

              // Center home button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapDown: (_) {
                    // Trigger visual feedback
                  },
                  onTap: () => onIndexChanged(4),
                  child: _CenterHomeButton(
                    isSelected: selectedIndex == 4,
                    palette: palette,
                  ),
                ),
              ),

              // Right side items (2)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _NavItemSmall(
                      index: 2,
                      isSelected: selectedIndex == 2,
                      label: t(_navKeys[2]),
                      icon: _icons[2][0],
                      activeIcon: _icons[2][1],
                      palette: palette,
                      onTap: () => onIndexChanged(2),
                    ),
                    _NavItemSmall(
                      index: 3,
                      isSelected: selectedIndex == 3,
                      label: t(_navKeys[3]),
                      icon: _icons[3][0],
                      activeIcon: _icons[3][1],
                      palette: palette,
                      onTap: () => onIndexChanged(3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItemSmall extends StatefulWidget {
  final int index;
  final bool isSelected;
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final AppPalette palette;
  final VoidCallback onTap;

  const _NavItemSmall({
    required this.index,
    required this.isSelected,
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.palette,
    required this.onTap,
  });

  @override
  State<_NavItemSmall> createState() => _NavItemSmallState();
}

class _NavItemSmallState extends State<_NavItemSmall> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: widget.isSelected ? 10 : 6,
          vertical: 6 + (_isPressed ? 2 : 0),
        ),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? widget.palette.primary.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.isSelected
                ? widget.palette.primary.withValues(alpha: 0.3)
                : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            if (_isPressed)
              BoxShadow(
                color: widget.palette.primary.withValues(alpha: 0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
                spreadRadius: 1,
              ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
              child: AnimatedScale(
                scale: _isPressed ? 0.88 : 1.0,
                duration: const Duration(milliseconds: 100),
                child: Icon(
                  widget.isSelected ? widget.activeIcon : widget.icon,
                  key: ValueKey<bool>(widget.isSelected),
                  size: 20,
                  color: widget.isSelected
                      ? widget.palette.primary
                      : widget.palette.mutedText,
                ),
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                color: widget.isSelected
                    ? widget.palette.primary
                    : widget.palette.mutedText,
                fontSize: 9,
                fontWeight: widget.isSelected ? FontWeight.w700 : FontWeight.w500,
                height: 1,
              ),
              child: Text(
                widget.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CenterHomeButton extends StatefulWidget {
  final bool isSelected;
  final AppPalette palette;

  const _CenterHomeButton({
    required this.isSelected,
    required this.palette,
  });

  @override
  State<_CenterHomeButton> createState() => _CenterHomeButtonState();
}

class _CenterHomeButtonState extends State<_CenterHomeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          return Transform.scale(
            scale: _isPressed
                ? 0.92
                : 1.0 + (sin(_pulseController.value * 3.14159 * 2) * 0.05),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    widget.palette.primary,
                    widget.palette.primary.withValues(alpha: 0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: widget.palette.primary.withValues(
                      alpha: _isPressed ? 0.6 : 0.4,
                    ),
                    blurRadius: _isPressed ? 12 : 20,
                    offset: const Offset(0, 8),
                    spreadRadius: _isPressed ? 0 : 2,
                  ),
                  if (widget.isSelected)
                    BoxShadow(
                      color: widget.palette.primary.withValues(
                        alpha: _isPressed ? 0.8 : 0.6,
                      ),
                      blurRadius: _isPressed ? 8 : 12,
                      offset: const Offset(0, 0),
                    ),
                ],
              ),
              child: Center(
                child: AnimatedScale(
                  scale: _isPressed ? 0.88 : 1.0,
                  duration: const Duration(milliseconds: 100),
                  child: Icon(
                    Icons.dashboard_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          );
        },
      );
  }
}

class _AnimatedNavTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final bool isSelected;
  final AppPalette palette;
  final VoidCallback onTap;

  const _AnimatedNavTab({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.isSelected,
    required this.palette,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 4,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? palette.primary.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 260),
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: FadeTransition(opacity: animation, child: child),
                ),
                child: Icon(
                  isSelected ? activeIcon : icon,
                  key: ValueKey<bool>(isSelected),
                  size: 22,
                  color: isSelected
                      ? palette.primary
                      : palette.mutedText,
                ),
              ),
              const SizedBox(height: 3),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 260),
                  style: TextStyle(
                    color: isSelected
                        ? palette.primary
                        : palette.mutedText,
                    fontSize: 10.5,
                    fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
