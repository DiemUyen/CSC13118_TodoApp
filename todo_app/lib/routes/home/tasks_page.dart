import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/app_theme.dart';
import 'package:todo_app/widgets/to_do_card.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key, required this.allTasks, required this.onDoneTaskCallback, required this.onUpdateTaskCallback, required this.onDeleteTaskCallback}) : super(key: key);

  final List<Task> allTasks;
  final void Function(int id) onDoneTaskCallback;
  final void Function() onUpdateTaskCallback;
  final void Function(int?) onDeleteTaskCallback;

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  var upcomingTasks = <Task>[];
  var todayTasks = <Task>[];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    todayTasks = widget.allTasks.where((element) =>DateFormat('dd MM yyyy').format(DateTime.now()) == DateFormat('dd MM yyyy').format(element.toDoTime)
    ).toList();
    upcomingTasks = widget.allTasks.where((element) =>
    DateFormat('dd MM yyyy').format(DateTime.now()) != DateFormat('dd MM yyyy').format(element.toDoTime)
        && element.toDoTime.isAfter(DateTime.now())
    ).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const GreetingBar(),
            const SizedBox(height: 8,),

            Container(
              child: TabBar(
                labelStyle: Theme.of(context).textTheme.titleSmall,
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
                  TodayTabView(
                    todayTasks: todayTasks,
                    onChangedCallback: widget.onDoneTaskCallback,
                    onDeleteCallback: widget.onDeleteTaskCallback,
                  ),
                  UpcomingTabView(
                    upcomingTasks: upcomingTasks,
                    onDoneTaskCallback: widget.onDoneTaskCallback,
                    onDeleteCallback: widget.onDeleteTaskCallback,
                  ),
                  AllTabView(
                    allTasks: widget.allTasks,
                    onChangedCallback: widget.onDoneTaskCallback,
                    onDeleteCallback: widget.onDeleteTaskCallback,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
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
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
  const TodayTabView({Key? key, required this.todayTasks, required this.onChangedCallback, required this.onDeleteCallback,}) : super(key: key);

  final List<Task> todayTasks;
  final void Function(int id) onChangedCallback;
  final void Function(int?) onDeleteCallback;

  @override
  Widget build(BuildContext context) {
    if (todayTasks.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: todayTasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey<Task>(todayTasks[index]),
            confirmDismiss: (DismissDirection direction) async {
              final result = await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Delete Confirmation'),
                    content: const Text('Are you sure you want to delete this task?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(Theme.of(context).textTheme.bodyMedium),
                          backgroundColor: MaterialStateProperty.all(AppTheme.lightTheme(null).colorScheme.primary,),
                          foregroundColor: MaterialStateProperty.all(AppTheme.lightTheme(null).colorScheme.onPrimary,),
                        ),
                        child: const Text('Delete'),
                      )
                    ],
                  );
                }
              );
              if (result as bool) {
                onDeleteCallback(todayTasks[index].taskId);
              }
            },
            child: ToDoCard(
              todo: todayTasks[index],
              onChangedCallback: onChangedCallback,
            ),
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
  const UpcomingTabView({Key? key, required this.upcomingTasks, required this.onDoneTaskCallback, required this.onDeleteCallback,}) : super(key: key);

  final List<Task> upcomingTasks;
  final void Function(int id) onDoneTaskCallback;
  final void Function(int?) onDeleteCallback;

  @override
  Widget build(BuildContext context) {
    if (upcomingTasks.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: upcomingTasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey<Task>(upcomingTasks[index]),
            confirmDismiss: (DismissDirection direction) async {
              final result = await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Delete Confirmation'),
                      content: const Text('Are you sure you want to delete this task?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          style: ButtonStyle(
                            textStyle: MaterialStateProperty.all(Theme.of(context).textTheme.bodyMedium),
                            backgroundColor: MaterialStateProperty.all(AppTheme.lightTheme(null).colorScheme.primary,),
                            foregroundColor: MaterialStateProperty.all(AppTheme.lightTheme(null).colorScheme.onPrimary,),
                          ),
                          child: const Text('Delete'),
                        )
                      ],
                    );
                  }
              );
              if (result as bool) {
                onDeleteCallback(upcomingTasks[index].taskId);
              }
            },
            child: ToDoCard(
              todo: upcomingTasks[index],
              onChangedCallback: onDoneTaskCallback,
            ),
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
  const AllTabView({Key? key, required this.allTasks, required this.onChangedCallback, required this.onDeleteCallback,}) : super(key: key);

  final List<Task> allTasks;
  final void Function(int id) onChangedCallback;
  final void Function(int?) onDeleteCallback;

  @override
  Widget build(BuildContext context) {
    if (allTasks.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: allTasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey<Task>(allTasks[index]),
            confirmDismiss: (DismissDirection direction) async {
              final result = await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Delete Confirmation'),
                      content: const Text('Are you sure you want to delete this task?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          style: ButtonStyle(
                            textStyle: MaterialStateProperty.all(Theme.of(context).textTheme.bodyMedium),
                            backgroundColor: MaterialStateProperty.all(AppTheme.lightTheme(null).colorScheme.primary,),
                            foregroundColor: MaterialStateProperty.all(AppTheme.lightTheme(null).colorScheme.onPrimary,),
                          ),
                          child: const Text('Delete'),
                        )
                      ],
                    );
                  }
              );
              if (result as bool) {
                onDeleteCallback(allTasks[index].taskId);
              }
            },
            child: ToDoCard(
              todo: allTasks[index],
              onChangedCallback: onChangedCallback,
            ),
          );
        },
      );
    }
    return const Center(
      child: Text('You don\'t have task\nCreate a task by pressing \'+\''),
    );
  }
}


