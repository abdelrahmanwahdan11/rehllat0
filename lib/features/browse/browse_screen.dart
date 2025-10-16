import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/services/app_state.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({required this.appState, super.key});

  final AppState appState;

  static const List<String> _categories = <String>[
    'Tourism',
    'Volunteer',
    'Learning',
    'Scientific',
    'Cultural',
    'Hiking',
    'Camping',
    'Private',
  ];

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return RefreshIndicator(
      onRefresh: () async {
        await Future<void>.delayed(const Duration(milliseconds: 400));
      },
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: l10n.getString('search_hint'),
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface.withOpacity(0.85),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.getString('filters_title'),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _buildFilterChips(context),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.getString('sort_title'),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: _buildSortChips(context),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.getString('tab_browse'),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.1,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: _categories
                .map(
                  (String category) => _CategoryCard(
                    label: category,
                    onTap: () => appState.setActiveGradientType(category),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFilterChips(BuildContext context) {
    const List<String> filters = <String>[
      'type',
      'price_range',
      'difficulty',
      'duration',
      'sponsored',
      'has_camping',
      'nearby_only',
    ];
    return filters
        .map(
          (String filter) => FilterChip(
            label: Text(filter),
            selected: false,
            onSelected: (_) {},
          ),
        )
        .toList();
  }

  List<Widget> _buildSortChips(BuildContext context) {
    const List<String> sorts = <String>[
      'relevance',
      'date_asc',
      'date_desc',
      'price_low_high',
      'price_high_low',
      'rating_desc',
    ];
    return sorts
        .map(
          (String sort) => ChoiceChip(
            label: Text(sort),
            selected: false,
            onSelected: (_) {},
          ),
        )
        .toList();
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface.withOpacity(0.85),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Center(
          child: Text(
            label,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
