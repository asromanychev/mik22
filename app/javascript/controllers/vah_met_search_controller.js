import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        console.log('connected')
        console.log(this.element)
    }

    toggleDates(e) {
        [...document.getElementsByClassName('vah-met-search-dates')].map(
            (element, index, array) => {
                $(element.firstChild).toggleClass('show')
            }
        );
    }
}
