import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data_access/data_provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/app_theme.dart';
import 'package:todo_app/utils/extensions.dart';
import 'package:todo_app/widgets/custom_app_bar.dart';
import 'package:todo_app/widgets/to_do_card.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  final DataProvider dataProvider = DataProvider.dataProvider;
  Future<List<Task>>? _dataFuture;
  var allTasks = <Task>[];
  var upcomingTasks = <Task>[];
  var todayTasks = <Task>[];


  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _dataFuture = getDatabase();
    super.initState();
  }

  Future<List<Task>> getDatabase() async {
    return await dataProvider.getAllTasks();
  }

  @override
  void dispose() {
    dataProvider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _dataFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          allTasks = snapshot.data;
          todayTasks = allTasks.where((element) =>
            DateTime.now().difference(element.toDoTime).inDays == 0 && element.toDo
          ).toList();
          upcomingTasks = allTasks.where((element) =>
            element.toDoTime.difference(DateTime.now()).inDays > 0 && element.toDo
          ).toList();
          return Scaffold(
            appBar: const CustomAppBar(title: 'Tasks'),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const GreetingBar(),
                  const SizedBox(height: 8,),

                  Container(
                    child: TabBar(
                      labelStyle: context.titleSmall,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: CircleTabIndicator(color: AppTheme.lightTheme(null).colorScheme.onSurfaceVariant, radius: 4),
                      controller: _tabController,
                      tabs: const [
                        Tab(
                          text: 'Today',
                        ),
                        Tab(
                          text: 'Upcoming',
                        ),
                        Tab(
                          text: 'All',
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        TodayTabView(todayTasks: todayTasks,),
                        UpcomingTabView(upcomingTasks: upcomingTasks,),
                        AllTabView(allTasks: allTasks,),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );

  }
}

const greetings = ['Good morning ', 'Good afternoon ', 'Good evening '];
final greetingIcons = [
  FaIcon(FontAwesomeIcons.sun, color: AppTheme.lightTheme(null).colorScheme.tertiary,),
  FaIcon(FontAwesomeIcons.cloudSun, color: AppTheme.lightTheme(null).colorScheme.tertiary,),
  FaIcon(FontAwesomeIcons.moon, color: AppTheme.lightTheme(null).colorScheme.tertiary,)];

class GreetingBar extends StatelessWidget {
  const GreetingBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    late int greetingIndex;
    var currentHour = DateTime.now().hour;

    if (0 <= currentHour && currentHour <= 11) {
      greetingIndex = 0;
    }
    else if (11 < currentHour && currentHour < 18) {
      greetingIndex = 1;
    }
    else {
      greetingIndex = 2;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: context.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.lightTheme(null).colorScheme.tertiary,
            ),
            children: [
              TextSpan(text: greetings[greetingIndex],),
              WidgetSpan(child: greetingIcons[greetingIndex],),
            ]
          ),
        ),
        Text(
          DateFormat('E, d MMM yyyy').format(DateTime.now()),
          style: context.titleMedium,
        )
      ],
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  const CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }

}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint();
    paint.color = color;
    paint.isAntiAlias = true;

    final Offset circleOffset = Offset(configuration.size!.width / 2 - radius / 2, configuration.size!.height - radius);

    canvas.drawCircle(offset + circleOffset, radius, paint);
  }

}

class TodayTabView extends StatelessWidget {
  const TodayTabView({Key? key, required this.todayTasks}) : super(key: key);

  final List<Task> todayTasks;

  @override
  Widget build(BuildContext context) {
    if (todayTasks.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: todayTasks.length,
        itemBuilder: (context, index) {
          return ToDoCard(
            todo: todayTasks[index],
          );
        },
      );
    }
    return const Center(
      child: Text('You don\'t have task today\nCreate a task by pressing \'+\''),
    );
  }
}

class UpcomingTabView extends StatelessWidget {
  const UpcomingTabView({Key? key, required this.upcomingTasks}) : super(key: key);

  final List<Task> upcomingTasks;

  @override
  Widget build(BuildContext context) {
    if (upcomingTasks.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: upcomingTasks.length,
        itemBuilder: (context, index) {
          return ToDoCard(
            todo: upcomingTasks[index],
          );
        },
      );
    }
    return const Center(
      child: Text('You don\'t have task upcoming\nCreate a task by pressing \'+\''),
    );
  }
}

class AllTabView extends StatelessWidget {
  const AllTabView({Key? key, required this.allTasks}) : super(key: key);

  final List<Task> allTasks;

  @override
  Widget build(BuildContext context) {
    if (allTasks.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: allTasks.length,
        itemBuilder: (context, index) {
          return ToDoCard(
            todo: allTasks[index],
          );
        },
      );
    }
    return const Center(
      child: Text('You don\'t have task\nCreate a task by pressing \'+\''),
    );
  }
}


