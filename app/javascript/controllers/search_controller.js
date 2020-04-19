import Rails from '@rails/ujs';

import { Controller } from "stimulus"

export default class extends Controller {
    static targets = [ 'field', 'submit' ];
    keydownSubmit() {
      console.log("keydown-start")
      const field = this.fieldTarget;
      const submit = this.submitTarget;
      $(submit).trigger("click")
      console.log("keydown-end")
    }
}

