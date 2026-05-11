import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Modern, glass-style app bar used across the app.
/// - Soft frosted background with a thin bottom hairline (no harsh shadow).
/// - Circular icon buttons with a smooth ripple, hover, and press animation.
/// - Optional search field, optional subtitle, optional notification badge.
class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final int? notificationCount;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onSettingsTap;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showSearch;

  const AppBarWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.notificationCount,
    this.onNotificationTap,
    this.onSettingsTap,
    this.leading,
    this.actions,
    this.showSearch = false,
  });

  @override
  Size get preferredSize {
    final hasSub = subtitle != null && subtitle!.isNotEmpty;
    return Size.fromHeight(hasSub ? 80 : 64);
  }

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  bool _showSearch = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    final hasSub = widget.subtitle != null && widget.subtitle!.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: p.bgTop,
        border: Border(
          bottom: BorderSide(
            color: p.border,
            width: 0.6,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (widget.leading != null) ...[
                    widget.leading!,
                    const SizedBox(width: 6),
                  ],
                  if (!_showSearch)
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              color: p.text,
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.3,
                              height: 1.15,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (hasSub) ...[
                            const SizedBox(height: 2),
                            Text(
                              widget.subtitle!,
                              style: TextStyle(
                                color: p.mutedText,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w500,
                                height: 1.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    )
                  else
                    Expanded(child: _buildSearchField(p)),
                  const SizedBox(width: 6),
                  if (widget.showSearch)
                    _IconBtn(
                      icon: _showSearch
                          ? Icons.close_rounded
                          : Icons.search_rounded,
                      onTap: () =>
                          setState(() => _showSearch = !_showSearch),
                    ),
                  if (widget.notificationCount != null) ...[
                    if (widget.showSearch) const SizedBox(width: 6),
                    _IconBtn(
                      icon: Icons.notifications_outlined,
                      onTap: widget.onNotificationTap,
                      badgeCount: widget.notificationCount,
                    ),
                  ],
                  if (widget.onSettingsTap != null) ...[
                    const SizedBox(width: 6),
                    _IconBtn(
                      icon: Icons.tune_rounded,
                      onTap: widget.onSettingsTap,
                    ),
                  ],
                  if (widget.actions != null) ...[
                    const SizedBox(width: 6),
                    ...widget.actions!,
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(AppPalette p) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: p.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: p.border),
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: p.mutedText, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: p.mutedText, fontSize: 13),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: TextStyle(color: p.text, fontSize: 13.5),
            ),
          ),
        ],
      ),
    );
  }
}

/// Modern circular icon button used in the app bar.
/// Subtle filled background, ripple on tap, press scale, and a tidy badge.
class _IconBtn extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final int? badgeCount;

  const _IconBtn({
    required this.icon,
    this.onTap,
    this.badgeCount,
  });

  @override
  State<_IconBtn> createState() => _IconBtnState();
}

class _IconBtnState extends State<_IconBtn> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    final hasBadge = widget.badgeCount != null && widget.badgeCount! > 0;
    const size = 40.0;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: SizedBox(
          width: size,
          height: size,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: _pressed
                      ? p.primary.withValues(alpha: 0.12)
                      : p.card,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _pressed
                        ? p.primary.withValues(alpha: 0.35)
                        : p.border,
                    width: 1,
                  ),
                  boxShadow: p.isDark
                      ? null
                      : [
                          BoxShadow(
                            color: p.shadow,
                            blurRadius: 6,
                            offset: const Offset(0, 1),
                          ),
                        ],
                ),
                child: Center(
                  child: Icon(
                    widget.icon,
                    color: p.text,
                    size: 19,
                  ),
                ),
              ),
              if (hasBadge)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF3B30),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: p.bgTop,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              const Color(0xFFFF3B30).withValues(alpha: 0.35),
                          blurRadius: 6,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        widget.badgeCount! > 99
                            ? '99+'
                            : '${widget.badgeCount}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          height: 1.0,
                        ),
                      ),
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
