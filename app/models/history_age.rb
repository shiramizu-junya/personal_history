class HistoryAge < ActiveHash::Base
  include ActiveHash::Associations
  has_many :events

  self.data = [
    {:id => 1, :age => "0〜5歳"},
    {:id => 2, :age => "6〜10歳"},
    {:id => 3, :age => "11〜15歳"},
    {:id => 4, :age => "16〜20歳"},
    {:id => 5, :age => "21〜25歳"},
    {:id => 6, :age => "26〜30歳"},
    {:id => 7, :age => "31〜35歳"},
    {:id => 8, :age => "36〜40歳"},
    {:id => 9, :age => "41〜45歳"},
    {:id => 10, :age => "46〜50歳"},
    {:id => 11, :age => "51〜55歳"},
    {:id => 12, :age => "56〜60歳"},
    {:id => 13, :age => "61〜65歳"},
    {:id => 14, :age => "66〜70歳"},
    {:id => 15, :age => "71〜75歳"},
    {:id => 16, :age => "76〜80歳"},
    {:id => 17, :age => "81〜85歳"},
    {:id => 18, :age => "86〜90歳"},
    {:id => 19, :age => "91〜95歳"},
    {:id => 20, :age => "96〜100歳"}
  ]
end
