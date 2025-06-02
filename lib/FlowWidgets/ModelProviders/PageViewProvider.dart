import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TabControllerProvider with ChangeNotifier {
  late final TabController tabController;

  TabControllerProvider() {
    // Default TabController setup with 2 tabs
    tabController = TabController(length: 2, vsync: const _NoTickerProvider());
    tabController.addListener(_onTabChange);
  }

  void _onTabChange() {
    if (!tabController.indexIsChanging) {
      print("Current Tab: ${tabController.index}");
      notifyListeners();
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}

// Custom TickerProvider for TabController
class _NoTickerProvider extends TickerProvider {
  const _NoTickerProvider();

  @override
  Ticker createTicker(onTick) => Ticker(onTick);
}
