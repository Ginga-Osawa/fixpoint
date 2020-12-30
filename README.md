# fixpoint

拡張子の前の数字が各設問とリンクしています。

## test-log.csv 
  各設問にて使用したテストデータです。

## surveillance_1.rb
  ### 実行結果
    $ ruby surveillance_1.rb                               
    ["10.20.30.1/16は20201019133324から20201019133401まで故障していました。", "10.20.30.1/16は20201019133411から20201019133431まで故障していました。"] 

## surveillance_2.rb
  第1引数に何回タイムアウトしたらエラーとするかを入力する  
  デフォルトは0
  ### 実行結果
    $ ruby surveillance_2.rb 2
    ["10.20.30.1/16は20201019133411から20201019133431まで故障していました。"]
    ruby surveillance_2.rb 3
    []

## surveillance_3.rb
  第1引数はsurveillance_2.rbと同じくタイムアウト回数  
  第2引数で平均何秒から過負荷状態とみなすかを設定：デフォルトは200  
  第3引数で平均をとる個数を設定：デフォルトは3  
  ### 実行結果
    ruby surveillance_3.rb 2 250 2
    ["10.20.30.1/16は20201019133411から20201019133431まで故障していました。"]
    {"10.20.30.1/16"=>["20201019133224", "20201019133324", "20201019133401", "20201019133411", "20201019133421", "20201019133431", "FIN"]}

## surveillance_4.rb
  未完成
