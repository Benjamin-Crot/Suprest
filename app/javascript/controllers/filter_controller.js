import Rails from '@rails/ujs';

import { Controller } from "stimulus"

export default class extends Controller {
    static targets = [ 'products', 'form' ];
    // submit () {
    //   const form = this.formTarget;
    //   Rails.fire(form, 'submit');
    //   const products = this.productTarget;
    //   products.innerHTML = ("<%= j render 'product', products: @products %>");
    //   console.log(form);
    //   console.log(products);
    //   console.log(this.productTarget);
    // }
    submit() {
      fetch('/products', { headers: { accept: "application/json" } })
        .then(response => response.json())
        .then((data) => {
          console.log(data);
        });
    }

}










