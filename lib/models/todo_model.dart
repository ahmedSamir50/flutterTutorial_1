
import 'package:untitled1/shared/components/constants.dart';

class TODOModel{
  late int id;
  late String title;
  late String timeOfCreation;
  late String lastStateTime;
  late TODOAPPTASKStatuses state;
  TODOModel(this.id, this.title , this.timeOfCreation , this.state , this.lastStateTime);

}