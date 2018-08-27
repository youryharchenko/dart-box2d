library BlobTest;

import 'dart:math' as Math;
import 'package:box2d_flame/box2d.dart';
import 'package:box2d_flame/src/math_utils.dart' as MathUtils;
import 'demo.dart';

class BlobTest extends Demo {
  /** Constructs a new BlobTest. */
  BlobTest() : super("Blob test");

  /** Entrypoint. */
  static void main() {
    final blob = new BlobTest();
    blob.initialize();
    blob.initializeAnimation();
    blob.runAnimation();
  }

  void initialize() {
    Body ground;
    {
      PolygonShape sd = new PolygonShape();
      sd.setAsBoxXY(50.0, 0.4);

      BodyDef bd = new BodyDef();
      bd.position.setValues(0.0, 0.0);
      assert(world != null);
      ground = world.createBody(bd);
      ground.createFixtureFromShape(sd);

      sd.setAsBox(0.4, 50.0, new Vector2(-10.0, 0.0), 0.0);
      ground.createFixtureFromShape(sd);
      sd.setAsBox(0.4, 50.0, new Vector2(10.0, 0.0), 0.0);
      ground.createFixtureFromShape(sd);
    }

    ConstantVolumeJointDef cvjd = new ConstantVolumeJointDef();

    double cx = 0.0;
    double cy = 10.0;
    double rx = 5.0;
    double ry = 5.0;
    double nBodies = 20.0;
    double bodyRadius = 0.5;
    for (int i = 0; i < nBodies; ++i) {
      double angle = MathUtils.translateAndScale(
          i.toDouble(), 0.0, nBodies, 0.0, Math.pi * 2);
      BodyDef bd = new BodyDef();
      bd.fixedRotation = true;

      double x = cx + rx * Math.sin(angle);
      double y = cy + ry * Math.cos(angle);
      bd.position.setFrom(new Vector2(x, y));
      bd.type = BodyType.DYNAMIC;
      Body body = world.createBody(bd);

      FixtureDef fd = new FixtureDef();
      CircleShape cd = new CircleShape();
      cd.radius = bodyRadius;
      fd.shape = cd;
      fd.density = 1.0;
      fd.filter.groupIndex = -2;
      body.createFixtureFromFixtureDef(fd);
      cvjd.addBody(body);
    }

    cvjd.frequencyHz = 10.0;
    cvjd.dampingRatio = 1.0;
    cvjd.collideConnected = false;
    world.createJoint(cvjd);

    BodyDef bd2 = new BodyDef();
    bd2.type = BodyType.DYNAMIC;
    PolygonShape psd = new PolygonShape();
    psd.setAsBox(3.0, 1.5, new Vector2(cx, cy + 15.0), 0.0);
    bd2.position = new Vector2(cx, cy + 15.0);
    Body fallingBox = world.createBody(bd2);
    fallingBox.createFixtureFromShape(psd, 1.0);
  }
}

void main() {
  BlobTest.main();
}