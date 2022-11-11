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

    openProgramSelect(e) {
        [...document.getElementsByClassName('vah-met-program-name')].map(
            (element, index, array) => {
                $(element.firstChild)[0].className += " show";
            }
        );
    }

    openOtherSelects(e) {
        [...document.getElementsByClassName('vah-met-parameter-name')].map(
            (element, index, array) => {
                $(element.firstChild)[0].className += " show";
            }
        );
        [...document.getElementsByClassName('vah-met-lot-packet'),
            ...document.getElementsByClassName('vah-met-lot-order'),
            ...document.getElementsByClassName('vah-met-wafer-number')
        ].map(
            (element, index, array) => {
                $(element)[0].classList.remove("collapse");
            }
        );
    }
}
