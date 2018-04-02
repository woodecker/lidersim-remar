package br.ufscar.sead.loa.lidersim.remar


class Anotacao {
    String informacao
    long ownerId

    static constraints = {
        informacao (nullable: false)
        ownerId blank: false, nullable: false
    }

    @Override
    String toString() {
        return informacao
    }
}
