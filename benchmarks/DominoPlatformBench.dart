/*******************************************************************************
 * Copyright (c) 2011, Daniel Murphy
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 * 	* Redistributions of source code must retain the above copyright notice,
 * 	  this list of conditions and the following disclaimer.
 * 	* Redistributions in binary form must reproduce the above copyright notice,
 * 	  this list of conditions and the following disclaimer in the documentation
 * 	  and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 ******************************************************************************/

/**
 * Demonstration of dominoes being knocked over.
 */
class DominoPlatformBench extends Benchmark {
  static final String NAME = "Domino Platforms";

  DominoPlatformBench(List<int> solveLoops, List<int> steps) :
    super(solveLoops, steps) { }

  String get name() {
    return NAME;
  }

  void initialize() {
    resetWorld();

    { // Floor
      FixtureDef fd = new FixtureDef();
      PolygonShape sd = new PolygonShape();
      sd.setAsBox(50.0, 10.0);
      fd.shape = sd;

      BodyDef bd = new BodyDef();
      bd.position = new Vector(0.0, -10.0);
      final body = world.createBody(bd);
      body.createFixture(fd);
      bodies.add(body);
    }

    { // Platforms
      for (int i = 0; i < 4; i++) {
        FixtureDef fd = new FixtureDef();
        PolygonShape sd = new PolygonShape();
        sd.setAsBox(15.0, 0.125);
        fd.shape = sd;

        BodyDef bd = new BodyDef();
        bd.position = new Vector(0.0, 5 + 5 * i);
        final body = world.createBody(bd);
        body.createFixture(fd);
        bodies.add(body);
      }
    }

    // Dominoes
    {
      FixtureDef fd = new FixtureDef();
      PolygonShape sd = new PolygonShape();
      sd.setAsBox(0.125, 2);
      fd.shape = sd;
      fd.density = 25.0;

      BodyDef bd = new BodyDef();
      bd.type = BodyType.DYNAMIC;

      num friction = .5;
      int numPerRow = 25;

      for (int i = 0; i < 4; ++i) {
        for (int j = 0; j < numPerRow; j++) {
          fd.friction = friction;
          bd.position = new Vector(-14.75 + j * (29.5 / (numPerRow - 1)),
              7.3 + 5 * i);
          if (i == 2 && j == 0) {
            bd.angle = -.1;
            bd.position.x += .1;
          } else if (i == 3 && j == numPerRow - 1) {
            bd.angle = .1;
            bd.position.x -= .1;
          } else {
            bd.angle = 0;
          }
          Body myBody = world.createBody(bd);
          myBody.createFixture(fd);
          bodies.add(myBody);
        }
      }
    }
  }
}
