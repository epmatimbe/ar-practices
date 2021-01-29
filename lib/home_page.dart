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
  double _radius = 0.4;
  double _reflectance = 1.0;
  double _roughness = 0.7;
  bool metallic = false;
  int _solid;
  ArCoreController arCoreController;

  _onArCoreViewCreated(ArCoreController _arcoreController) {
    arCoreController = _arcoreController;
    if (_solid == 0)
      _addSphere(arCoreController);
    else if (_solid == 1)
      _addCube(arCoreController);
    else if (_solid == 2) _addCyclinder(arCoreController);
  }

  _addSphere(ArCoreController _arcoreController) {
    final material = ArCoreMaterial(
        color: Colors.red,
        metallic: metallic ? 1 : 0,
        reflectance: _reflectance,
        roughness: 0);
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.2,
    );
    final node = ArCoreNode(
      name: 'node',
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
    final material = ArCoreMaterial(
        color: Colors.red,
        metallic: metallic ? 1 : 0,
        reflectance: _reflectance,
        roughness: 0);
    final cylinder =
        ArCoreCylinder(materials: [material], radius: 0.4, height: 0.3);
    final node = ArCoreNode(
      name: 'node',
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
    final material = ArCoreMaterial(
        color: Colors.red,
        metallic: metallic ? 1 : 0,
        reflectance: _reflectance,
        roughness: 0);
    final cube =
        ArCoreCube(materials: [material], size: vector.Vector3(1, 1, 1));
    final node = ArCoreNode(
      name: 'node',
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
          actions: [
            IconButton(
                icon: Icon(Icons.info),
                onPressed: () {
                  showDialog(
                    context: context,
                    child: AlertDialog(
                      title: Text('Sobre a aplicação'),
                      content: Text(
                          'Este é o projecto básico de teste de AR. A aplicação AR Experimental foi desenvolvida para servir de DEMO para uma implementação e teste de Realidade Aumentada. \n\nDesenvolvida por:\nAlmirante Rodrigues\nEdson Matimbe\nNemias Sitoe\n\nRedes Multímedia\nUniversidade Pedagógica de Maputo 2021'),
                      actions: [
                        FlatButton.icon(
                            label: Text('Certo'),
                            icon: Icon(Icons.thumb_up),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                            })
                      ],
                    ),
                    barrierDismissible: true,
                    useRootNavigator: true,
                  );
                })
          ],
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
                        debug: false,
                        onArCoreViewCreated: _onArCoreViewCreated,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PopupMenuButton<int>(
                            child: CircleAvatar(
                              radius: 25.0,
                              child: Icon(Icons.add),
                            ),
                            onSelected: (int _solid) {
                              setState(() async {
                                await arCoreController.removeNode(
                                    nodeName: 'node');
                                if (_solid == 0)
                                  _addCube(arCoreController);
                                else if (_solid == 1)
                                  _addSphere(arCoreController);
                                else if (_solid == 2)
                                  _addCyclinder(arCoreController);
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
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Padding(
                    //       padding: EdgeInsets.symmetric(horizontal: 16.0),
                    //       child: Text('Raio'),
                    //     ),
                    //     Slider(
                    //       min: 0.0,
                    //       max: 1.0,
                    //       value: _radius,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           _radius = value;
                    //         });
                    //       },
                    //     )
                    //   ],
                    // ),
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
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Padding(
                    //       padding: EdgeInsets.symmetric(horizontal: 16.0),
                    //       child: Text('Roughness'),
                    //     ),
                    //     Slider(
                    //       min: 0.0,
                    //       max: 1.0,
                    //       value: _roughness,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           _roughness = value;
                    //         });
                    //       },
                    //     )
                    //   ],
                    // )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
