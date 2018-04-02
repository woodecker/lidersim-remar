package br.ufscar.sead.loa.lidersim.remar

class ThemeAnotacao {
    String informacao

    static constraints = {
        informacao (nullable: false)
    }

    @Override
    String toString() {
        return informacao
    }

}
