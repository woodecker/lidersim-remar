package br.ufscar.sead.loa.lidersim.remar

import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment
import org.springframework.web.multipart.MultipartFile

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["isAuthenticated()"])
class ProjetoController {

    def springSecurityService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def beforeInterceptor = [action: this.&check, only: ['index', 'exportProjetos','save', 'update', 'delete']]

    private check() {
        if (springSecurityService.isLoggedIn())
            session.user = springSecurityService.currentUser
        else {
            log.debug "Logout: session.user is NULL !"
            session.user = null
            redirect controller: "login", action: "index"

            return false
        }
    }

    @Secured(['permitAll'])
    def index(Integer max) {
        if (params.t) {
            session.taskId = params.t
        }
        if (params.p) {
            session.processId = params.p
        }
        session.user = springSecurityService.currentUser

       def list = Projeto.findAllByOwnerId(session.user.id)
        println list
        respond list, model: [ProjetoInstanceCount: Projeto.count(), errorImportQuestions:params.errorImportQuestions]
    }

    def show(Projeto projetoInstance) {
        respond projetoInstance
    }

    def create() {
        respond new Projeto(params)
    }


    @Transactional
    def save(Projeto projetoInstance) {
        if (projetoInstance == null) {
            notFound()
            return
        }

        if (projetoInstance.hasErrors()) {
            respond projetoInstance.errors, view:'create'
            render projetoInstance.errors;
            return
        }
        projetoInstance.ownerId = session.user.id as long
        projetoInstance.save flush:true

        redirect(action: "index")
    }

    def edit(Projeto projetoInstance) {
        respond projetoInstance
    }

    @Transactional
    def update() {
        Projeto projetoInstance = Projeto.findById(Integer.parseInt(params.ProjetoID))
        projetoInstance.informacao = params.projeto
        projetoInstance.orcamento = Integer.parseInt(params.orcamento)
        projetoInstance.ownerId = session.user.id as long
        projetoInstance.save flush:true

        redirect action: "index"
    }


    @Transactional
    def delete(Projeto projetoInstance) {
        if (projetoInstance == null) {
            notFound()
            return
        }

        projetoInstance.delete flush: true
        redirect action: "index"
    }


    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'projeto.label', default: 'Projeto'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }



    @Secured(['permitAll'])
    def returnInstance(Projeto projetoInstance){
        if (projetoInstance == null) {
            notFound()
            render "null"
        }
        else{
            render projetoInstance.informacao + "%@!" + projetoInstance.id + "%@!" + projetoInstance.orcamento
        }

    }



@Transactional
def exportProjetos(){
    //popula a lista de questoes a partir do ID de cada uma
    ArrayList<Integer> list_projetoId = new ArrayList<Integer>() ;
    ArrayList<Projeto> projetoList = new ArrayList<Projeto>();
    list_projetoId.addAll(params.list_id);
    for (int i=0; i<list_projetoId.size();i++)
        projetoList.add(Projeto.findById(list_projetoId[i]));

    //cria o arquivo json
    createJsonFile("projetos.json", projetoList)

    // Finds the created file path
    def folder = servletContext.getRealPath("/data/${springSecurityService.currentUser.id}/${session.taskId}")
    String id = MongoHelper.putFile("${folder}/projetos.json")


    def port = request.serverPort
    if (Environment.current == Environment.DEVELOPMENT) {
        port = 8080
    }

    // Updates current task to 'completed' status
    render  "http://${request.serverName}:${port}/process/task/complete/${session.taskId}?files=${id}"
}

void createJsonFile(String fileName, ArrayList<Projeto> projetoList) {
    def dataPath = servletContext.getRealPath("/data")
    def instancePath = new File("${dataPath}/${springSecurityService.currentUser.id}/${session.taskId}")
    instancePath.mkdirs()

    File file = new File("$instancePath/" + fileName);
    def bw = new BufferedWriter(new OutputStreamWriter(
            new FileOutputStream(file), "UTF-8"));

    bw.write("{\n")
    bw.write("\t\"quantidadeProjetos\": \"" + projetoList.size() + "\",\n")
    for (def i = 0; i < projetoList.size(); i++) {

        // replace " by /"
        def nota = projetoList[i].informacao.replace("\"","\\\"")
        
        // replace /n by ///n
        nota = nota.replace('\n', '\\\\n').replace("\r", "\\\\r")
        
        bw.write("\t\"nota" + (i + 1) + "\": \"" + nota + ";" + projetoList[i].orcamento + "\" ")
            
        if (i < projetoList.size() - 1)
            bw.write(",")
        bw.write("\n")
    }
    bw.write("}");
    bw.close();

    //se o arquivo .json nao existe, cria ele com nenhuma fase opcional
    def projetosFolder = new File("${dataPath}/${springSecurityService.currentUser.id}/processes/${session.processId}")
    projetosFolder.mkdirs()
    File projetosJson = new File("$projetosFolder/projetos.json")
    boolean exists = projetosJson.exists()
    if (!exists) {
        PrintWriter printer = new PrintWriter(projetosJson);
        printer.write("{\n");
        printer.write("\t\"quantidade\": \"0\",\n")
        printer.write("\t\"projetos\": \"1\", \"2\"\n")
        printer.write("}")
        printer.close();
    }
}

}
