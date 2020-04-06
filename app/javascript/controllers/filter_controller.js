import Rails from '@rails/ujs';

import { Controller } from "stimulus"

export default class extends Controller {
    static targets = [ 'product', 'form' ];
    submit () {
      const form = this.formTarget;
      Rails.fire(form, 'submit');
      const products = this.productTarget;
      // products.innerHTML = ("<%= j render 'product', products: @products %>");
      console.log(form);
      console.log(products);
      console.log(this.productTarget);
      // $(this.productTarget).html("<%= escape_javascript(render partial: 'products/product') %>");


    }

}










