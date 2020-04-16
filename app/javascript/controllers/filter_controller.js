import Rails from '@rails/ujs';

import { Controller } from "stimulus"

export default class extends Controller {
    static targets = [ 'products', 'form', 'search' ];
    clickSubmit() {
      const form = this.formTarget;
      const search = this.searchTarget;
      $(search).trigger("click")
    }
}










