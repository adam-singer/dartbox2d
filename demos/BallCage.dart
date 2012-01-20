#library('BallCage');
#import('dart:html');
#import('../lib/box2d.dart');
#source('demo.dart');

// Copyright 2012 Google Inc. All Rights Reserved.
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//     http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

class BallCage extends Demo {
  static final String NAME = "Ball Cage";

  /** Starting position of ball cage in the world. */
  static final num START_X = -20;
  static final num START_Y = -20;

  /** The radius of the balls forming the arena. */
  static final num WALL_BALL_RADIUS = 2;

  /** Radius of the active ball. */
  static final num ACTIVE_BALL_RADIUS = 1;

  /** Constructs a new BallCage. */
  BallCage() : super() { }

  /** Entrypoint. */
  static void main() {
    final cage = new BallCage();
    cage.initialize();
    cage.initializeAnimation();
    cage.runAnimation();
  }

  String get name() => NAME;

  void initialize() {
    // Define the circle shape.
    final circleShape = new CircleShape();
    circleShape.radius = WALL_BALL_RADIUS;

    // Create fixture using the circle shape.
    final circleFixtureDef = new FixtureDef();
    circleFixtureDef.shape = circleShape;
    circleFixtureDef.friction = .9;
    circleFixtureDef.restitution = 1;

    // Create a body def.
    final circleBodyDef = new BodyDef();

    int maxShapeinRow = 10;
    final num borderLimitX = START_X + maxShapeinRow * 2 * circleShape.radius;
    final num borderLimitY = START_Y + maxShapeinRow * 2 * circleShape.radius;

    for (int i = 0; i < maxShapeinRow; i++) {
      final num shiftX = START_X + circleShape.radius * 2 * i;
      final num shiftY = START_Y + circleShape.radius * 2 * i;

      circleBodyDef.position = new Vector(shiftX, START_Y);
      Body circleBody = world.createBody(circleBodyDef);
      bodies.add(circleBody);
      circleBody.createFixture(circleFixtureDef);

      circleBodyDef.position = new Vector(shiftX, borderLimitY);
      circleBody = world.createBody(circleBodyDef);
      bodies.add(circleBody);
      circleBody.createFixture(circleFixtureDef);

      circleBodyDef.position = new Vector(START_X, shiftY);
      circleBody = world.createBody(circleBodyDef);
      bodies.add(circleBody);
      circleBody.createFixture(circleFixtureDef);

      circleBodyDef.position = new Vector(borderLimitX, shiftY);
      circleBody = world.createBody(circleBodyDef);
      bodies.add(circleBody);
      circleBody.createFixture(circleFixtureDef);
    }

    // Create a bouncing ball.
    final bouncingCircle = new CircleShape();
    bouncingCircle.radius = ACTIVE_BALL_RADIUS;

    // Create fixture for that ball shape.
    final activeFixtureDef = new FixtureDef();
    activeFixtureDef.restitution = 1;
    activeFixtureDef.density =  0.05;
    activeFixtureDef.shape = bouncingCircle;

    // Create the active ball body.
    final activeBodyDef = new BodyDef();
    activeBodyDef.linearVelocity = new Vector(0, -20);
    activeBodyDef.position = new Vector(15, 15);
    activeBodyDef.type = BodyType.DYNAMIC;
    activeBodyDef.bullet = true;
    final activeBody = world.createBody(activeBodyDef);
    bodies.add(activeBody);
    activeBody.createFixture(activeFixtureDef);
  }
}

void main() {
  BallCage.main();
}
