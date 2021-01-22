import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _reflectance = 0;
  double _roughness = 0;
  bool metallic = false;
  int _solid;
  ArCoreController arCoreController;

  _onArCoreViewCreated(ArCoreController _arcoreController) {
    arCoreController = _arcoreController;
    _addSphere(arCoreController);
    // _addCube(arCoreController);
    // _addCyclinder(arCoreController);
  }

  _addSphere(ArCoreController _arcoreController) {
    final material = ArCoreMaterial(
        color: Colors.red, metallic: metallic?1:0, reflectance: _reflectance, roughness: 0);
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.2,
    );
    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(
        0,
        0,
        -1,
      ),
    );

    _arcoreController.addArCoreNode(node);
  }

  _addCyclinder(ArCoreController _arcoreController) {
    final material = ArCoreMaterial(color: Colors.green, reflectance: 1);
    final cylinder =
        ArCoreCylinder(materials: [material], radius: 0.4, height: 0.3);
    final node = ArCoreNode(
      shape: cylinder,
      position: vector.Vector3(
        0,
        -2.5,
        -3.0,
      ),
    );

    _arcoreController.addArCoreNode(node);
  }

  _addCube(ArCoreController _arcoreController) {
    final material = ArCoreMaterial(color: Colors.pink, metallic: 1);
    final cube =
        ArCoreCube(materials: [material], size: vector.Vector3(1, 1, 1));
    final node = ArCoreNode(
      shape: cube,
      position: vector.Vector3(
        -0.5,
        -0.5,
        -3,
      ),
    );

    _arcoreController.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double mdqWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                width: mdqWidth,
                child: Stack(
                  children: [
                    Expanded(
                      child: ArCoreView(
                        onArCoreViewCreated: _onArCoreViewCreated,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PopupMenuButton<int>(
                            child: CircleAvatar(radius: 25.0,
                              child: Icon(Icons.add),
                            ),
                            onSelected: (int result) {
                              setState(() {
                                _solid = result;
                                print(_solid);
                              });
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<int>>[
                              const PopupMenuItem<int>(
                                value: 0,
                                child: Text('Cubo'),
                              ),
                              const PopupMenuItem<int>(
                                value: 1,
                                child: Text('Esfera'),
                              ),
                              const PopupMenuItem<int>(
                                value: 2,
                                child: Text('Cilindro'),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: mdqWidth,
              child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: metallic,
                          onChanged: (value) {
                            setState(() {
                              metallic = value;
                            });
                          },
                        ),
                        Text('Metalico')
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('Brilho'),
                        ),
                        Slider(
                          min: 0.0,
                          max: 1.0,
                          value: _reflectance,
                          onChanged: (value) {
                            setState(() {
                              _reflectance = value;
                            });
                          },
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('Roughness'),
                        ),
                        Slider(
                          min: 0.0,
                          max: 1.0,
                          value: _roughness,
                          onChanged: (value) {
                            setState(() {
                              _roughness = value;
                            });
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
