import 'dart:html';

import 'ball_cage.dart';
import 'blob_test.dart';
import 'box_test.dart';
import 'circle_stress.dart' as cs;
import 'domino_test.dart' as dt;
import 'domino_tower.dart';
import 'friction_joint_test.dart';
import 'racer.dart';

/*
var demos = [
        'ball_cage',
        'blob_test',
        'box_test',
        'circle_stress',
        'domino_test',
        'domino_tower',
        'friction_joint_test',
        'racer'
      ];
      function getQueryVariable(variable) {
        var query = window.location.search.substring(1);
        var vars = query.split('&');
        for (var i = 0; i < vars.length; i++) {
            var pair = vars[i].split('=');
            if (pair[0] == variable) {
                return unescape(pair[1]);
            }
        }
        return null;
      }
      console.log('Checking for specific demo');
      var demo = getQueryVariable('demo');
      if (demo && demos.indexOf(demo) != -1) {
        console.log('Loading ' + demo);
        document.getElementById('fps').style.display = 'block';
        document.getElementById('world-step').style.display = 'block';
        var script = document.createElement('script');
        script.setAttribute('defer', '');
        script.setAttribute('src', demo + '.dart.js');
        document.body.appendChild(script);
      } else {
        console.log('Creating menu');
        document.getElementById('fps').style.display = 'none';
        document.getElementById('world-step').style.display = 'none';
        document.body.appendChild(document.createTextNode('Choose a demo:'));
        var menu = document.createElement('ul');
        for (var d in demos) {
          var item = document.createElement('li');
          var link = document.createElement('a');
          link.setAttribute('href', window.location.href + '?demo=' + demos[d]);
          link.appendChild(document.createTextNode(demos[d]));
          item.appendChild(link);
          menu.appendChild(item);
        }
        document.body.appendChild(menu);
      }
*/

final demos = <String>[
  'ball_cage',
  'blob_test',
  'box_test',
  'circle_stress',
  'domino_test',
  'domino_tower',
  'friction_joint_test',
  'racer',
];

final demoMains = <String, Function>{
  'ball_cage': BallCage.main,
  'blob_test': BlobTest.main,
  'box_test': BoxTest.main,
  'circle_stress': cs.main,
  'domino_test': dt.main,
  'domino_tower': DominoTower.main,
  'friction_joint_test': FrictionJointTest.main,
  'racer': Racer.main,
};

void main() {
  // querySelector('#output').text = 'Your Dart app is running.';

  print('Checking for specific demo');

  final demo = Uri.base.queryParameters['demo'];
  final body = querySelector('body');
  //final head = querySelector('head');

  if (demos.indexOf(demo) > -1) {
    print('Loading $demo');

    querySelector('#fps').style.display = 'block';
    querySelector('#world-step').style.display = 'block';
    
    if (demoMains.containsKey(demo)) {
      demoMains[demo]();
    }

  } else {
    print('Creating menu');

    querySelector('#fps').style.display = 'none';
    querySelector('#world-step').style.display = 'none';

    body.appendText('Choose a demo:');   //appendChild(document.createTextNode('Choose a demo:'));

    final menu = UListElement();
    for (var d in demos) {
      final item = LIElement();
      final link = AnchorElement(href: '${window.location.href}?demo=$d');
      link.appendText(d);
      item.append(link);
      menu.append(item);
    }

    body.append(menu);
  }

}
