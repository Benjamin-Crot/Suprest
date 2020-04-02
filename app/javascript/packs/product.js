console.log("Hello It's Ben Javascript")

function replaceProducts (innerHTML) {
  const products = document.getElementById('products');
  products.innerHTML = innerHTML;
}
replaceProducts("<%= j render 'product', products: @products %>");



