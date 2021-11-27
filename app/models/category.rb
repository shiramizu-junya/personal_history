class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: "学校" },
    { id: 2, name: "仕事" },
    { id: 3, name: "恋愛" },
    { id: 4, name: "家庭" },
    { id: 5, name: "友人" },
    { id: 6, name: "資格・免許" },
    { id: 7, name: "趣味" },
    { id: 8, name: "旅行" },
    { id: 9, name: "お金" },
    { id: 10, name: "その他" },
  ]
end
