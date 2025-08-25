import 'package:flutter/material.dart';
import 'package:mobile_app/core/providers/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/l10n/app_localizations.dart';

class CustomHomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onSearchTap;

  const CustomHomeAppBar({
    super.key,
    required this.onSearchTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomHomeAppBar> createState() => _CustomHomeAppBarState();
}

class _CustomHomeAppBarState extends State<CustomHomeAppBar> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.primaryColor,
      title: !_isSearching
          ? Text(
              loc.translate('restaurants'),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          : TextField(
              controller: _searchController,
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: loc.translate('search'),
                hintStyle: const TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),
              onSubmitted: (value) {
                widget.onSearchTap();
                setState(() => _isSearching = false);
              },
            ),
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        if (!_isSearching)
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () => setState(() => _isSearching = true),
          )
        else
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => setState(() => _isSearching = false),
          ),
      ],
    );
  }
}

// Le menu latéral (Drawer)
class CustomHomeDrawer extends StatelessWidget {
  const CustomHomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final localeProvider = Provider.of<LocaleProvider>(context);
    String selectedLang = localeProvider.locale.languageCode;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.grey),
            ),
            accountName: const Text("Utilisateur invité"),
            accountEmail: const Text("guest@example.com"),
          ),
          ListTile(
            leading: const Icon(Icons.login),
            title: Text(loc.translate('login')),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.person_add),
            title: Text(loc.translate('signup')),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(loc.translate('language')),
            subtitle: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedLang,
                items: [
                  DropdownMenuItem(
                    value: 'fr',
                    child: Row(
                      children: [
                        const Text("🇫🇷 ", style: TextStyle(fontSize: 18)),
                        Text(loc.translate('french')),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'en',
                    child: Row(
                      children: [
                        const Text("🇬🇧 ", style: TextStyle(fontSize: 18)),
                        Text(loc.translate('english')),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'ar',
                    child: Row(
                      children: [
                        const Text("🇸🇦 ", style: TextStyle(fontSize: 18)),
                        Text(loc.translate('arabic')),
                      ],
                    ),
                  ),
                ],
                onChanged: (val) {
                  if (val != null) localeProvider.setLocale(Locale(val));
                },
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(loc.translate('profile_settings')),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
