import { Application } from "@hotwired/stimulus"
import CarouselController from "./carousel_controller"
import ModalController    from "./modal_controller"

const application = Application.start()
application.register("carousel", CarouselController)
application.register("modal",    ModalController)