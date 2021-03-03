import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() => runApp(new MyApp());

@immutable
class AppState {
  final counter;
  AppState(this.counter);
}

//action
enum Actions { Increment, Decrement }

//pure function
AppState reducer(AppState prev, action) {
  if (action == Actions.Increment) {
    return AppState(prev.counter + 1);
  } else if (action == Actions.Decrement) {
    return AppState(prev.counter - 1);
  }
  return prev;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final store = Store(reducer, initialState: AppState(0));

  @override
  Widget build(BuildContext context) {
    return StoreProvider<dynamic>(
        store: store,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Flutter Redux App"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                StoreConnector(
                  converter: (store) => store.state.counter,
                  builder: (context, counter) => Text(
                    '$counter',
                    style: Theme.of(context).textTheme.display1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StoreConnector(
                      converter: (store) {
                        return () => store.dispatch(Actions.Increment);
                      },
                      builder: (context, callback) => FloatingActionButton(
                        onPressed: callback,
                        tooltip: 'Increment',
                        child: Icon(Icons.add),
                      ), // This trailing comma makes auto-formatting nicer for build methods.
                    ),
                    StoreConnector(
                      converter: (store) {
                        return () => store.dispatch(Actions.Decrement);
                      },
                      builder: (context, callback) => FloatingActionButton(
                        onPressed: callback,
                        tooltip: 'Decrement',
                        child: Icon(Icons.remove),
                      ), // This trailing comma makes auto-formatting nicer for build methods.
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
