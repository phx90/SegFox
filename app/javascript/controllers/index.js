import { Application } from "@hotwired/stimulus"
import CarouselController from "controllers/carousel_controller"
import ModalController    from "controllers/modal_controller"

const application = Application.start()
application.register("carousel", CarouselController)
application.register("modal",    ModalController)
