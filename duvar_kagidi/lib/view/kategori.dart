class CategorieModel {
  late String categorieName;
  late String imgUrl;

  static List<CategorieModel> getCategories() {
    List<CategorieModel> categories = [];
    CategorieModel categorieModel = CategorieModel();

    //
    categorieModel.imgUrl =
    "https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
    categorieModel.categorieName = "Sokak sanatı";
    categories.add(categorieModel);
    categorieModel = CategorieModel();

    //
    categorieModel.imgUrl =
    "https://images.pexels.com/photos/704320/pexels-photo-704320.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
    categorieModel.categorieName = "Hayvanlar";
    categories.add(categorieModel);
    categorieModel = CategorieModel();

    //
    categorieModel.imgUrl =
    "https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500";
    categorieModel.categorieName = "Doğa";
    categories.add(categorieModel);
    categorieModel = CategorieModel();

    //
    categorieModel.imgUrl =
    "https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
    categorieModel.categorieName = "Şehir";
    categories.add(categorieModel);
    categorieModel = CategorieModel();

    //
    categorieModel.imgUrl =
    "https://images.pexels.com/photos/1434819/pexels-photo-1434819.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260";
    categorieModel.categorieName = "Motivasyon";

    categories.add(categorieModel);
    categorieModel = CategorieModel();

    //
    categorieModel.imgUrl =
    "https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
    categorieModel.categorieName = "Bisikletler";
    categories.add(categorieModel);
    categorieModel = CategorieModel();

    //
    categorieModel.imgUrl =
    "https://images.pexels.com/photos/1149137/pexels-photo-1149137.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
    categorieModel.categorieName = "Arabalar";
    categories.add(categorieModel);
    categorieModel = CategorieModel();

    return categories;
  }


}

