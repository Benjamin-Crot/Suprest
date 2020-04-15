import Rails from '@rails/ujs';

import { Controller } from "stimulus"

export default class extends Controller {
    static targets = [ 'products', 'form', 'search' ];
    // submit () {
    //   const form = this.formTarget;
    //   Rails.fire(form, 'submit');
    //   const products = this.productTarget;
    //   products.innerHTML = ("<%= j render 'product', products: @products %>");
    //   console.log(form);
    //   console.log(products);
    //   console.log(this.productTarget);
    // }
    clickSubmit() {
      // $("#search_submit").trigger("click")
      console.log("hello")
      const form = this.formTarget;
      const search = this.searchTarget;
      console.log(form)
      console.log(search)
      $(search).trigger("click")

      Rails.fire(form, 'submit');
    }

}










