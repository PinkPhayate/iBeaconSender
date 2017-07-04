# iBeaconSender

色々サンプルはあるけど、swift3に対応したものがなかったのでメモしました。
(見つけられなかっただけかも)

iBeaconの発信機の役割をします。
テストの時とかに使用してください。


## Dependency

- CoreBluetooth
- CoreLocation


## feature
アプリを実行すると、そのデバイスがiBeaconのsenderへと化します。
テキストラベルの値に準じて、minor値とmajor値を変化させることができます。
残念ながら、uuidに関しては直接ソースコードで値を指定しちゃってます。
Sorry.....
