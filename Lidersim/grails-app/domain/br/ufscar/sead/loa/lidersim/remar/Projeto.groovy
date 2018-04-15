package br.ufscar.sead.loa.lidersim.remar

class Projeto {
    String informacao
    int orcamento
    long ownerId

    static constraints = {
        informacao nullable: false, maxsize: 280
        orcamento blank: false, nullable: false
        ownerId blank: false, nullable: false
    }

    @Override
    String toString() {
        return informacao
    }
}
