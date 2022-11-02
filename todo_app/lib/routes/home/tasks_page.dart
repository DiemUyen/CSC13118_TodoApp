import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                children: const [
                  TodayTabView(),
                  UpcomingTabView(),
                  AllTabView(),
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
          'Diem Uyen',
          style: context.titleMedium,
        )
      ],
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

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
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;

    final Offset circleOffset = Offset(configuration.size!.width / 2 - radius / 2, configuration.size!.height - radius);

    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }

}

class TodayTabView extends StatelessWidget {
  const TodayTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: 10,
      itemBuilder: (context, index) {
        return ToDoCard(
          isChecked: false,
          todo: Task(
            id: 1,
            name: 'Mobile design UI',
            description: 'Design prototype for Authentication flow',
            toDo: true,
            toDoTime: DateTime.now(),
            projectName: 'Advanced Mobile Development',
          ),
        );
      },
    );
  }
}

class UpcomingTabView extends StatelessWidget {
  const UpcomingTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: 10,
      itemBuilder: (context, index) {
        return ToDoCard(
          isChecked: false,
          todo: Task(
            id: 1,
            name: 'Mobile design UI',
            description: 'Design prototype for Authentication flow',
            toDo: true,
            toDoTime: DateTime.now(),
            projectName: 'Advanced Mobile Development',
          ),
        );
      },
    );
  }
}

class AllTabView extends StatelessWidget {
  const AllTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: 10,
      itemBuilder: (context, index) {
        return ToDoCard(
          isChecked: false,
          todo: Task(
            id: 1,
            name: 'Mobile design UI',
            description: 'Design prototype for Authentication flow',
            toDo: true,
            toDoTime: DateTime.now(),
            projectName: 'Advanced Mobile Development',
          ),
        );
      },
    );
  }
}


