stl

Card(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                FadeRoute(page: Videos()),
                              );
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                // decoration:
                                //     BoxDecoration(color: Colors.lightBlue[50]),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/video.png",
                                        width: 100,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text("Informative Videos",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.w800)),
                                            box10,
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              child: Text(
                                                'Watch Informative Videos\non Covid',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: 13),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),