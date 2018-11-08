# iOSProductListMobileApp
iOSProductListMobileApp

The Mobile app and the API interface map to the trailing features:
1. Connection to RESTful API to retrieve the product list (image, price, description) in form of JSON information. 
2. All communication with the API are performed asynchronously and using
a child thread.
3. The Product library list displays a section for each category, and under each category
displays the items retrieved for this category. The title of each section matches
the title of the category.
4. There are three different cell types based on the following requirements:
a. If for an item the “otherImage” and “summary” are null then the app displays the simple row
shown.
b. If for an item the “otherImage” is not null and the “summary” is null then the app displays
the large image based row shown.
c. If for an item the “otherImage” is null and the “summary” is not null then the app displays
the summary based based row shown.
5. All image uploading is performed using the SDWebImage library. 
AlamoFire is used for making the HTTP connections.
