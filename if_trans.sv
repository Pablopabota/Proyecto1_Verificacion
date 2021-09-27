// Defino el tipo de transaccion posibles en el controlador
typedef enum { none, t_push, t_pop, t_pp } tipo_trans;
    // none: En este caso el controlador deberia pasar el turno
    // push: el controlador solicita enviar un msje
    // pop: el controlador solicita leer un msje
    // push-pop: el controlador solicita enviar un mensaje y recibir otro

// Transaccion: Aca se define el objeto que representa los datos que pasan por el controlador
class trans_ctrl #(parameter width = 16);
    // A continuacion los parametros necesarios para interactuar con el DUT
    rand int delay;             // Retardo previo al envio del mensaje
    rand bit [width-1:0] data;  // Dato a enviar o recibir ( { [width-1:width-8] addr, [width-9:0] payload } )
    int tiempo;                 // Momento en que sucede la transaccion
    rand tipo_trans tipo;
    int max_delay;

    constraint const_delay { delay < max_delay; delay > 0; }

    function new(
            // Valores por defecto
            int dly = 0,
            bit [width-1:0] dta = 0,
            int tmp=0,
            tipo_trans tpo = none,
            int mx_dly = 10
        );
        // Aca se inicializa el tipo de transaccion
        this.delay = dly;
        this.data = dta;
        this.tiempo = tmp;
        this.tipo = tpo;
        this.max_delay = mx_dly;
    endfunction //new()

    function clean;
        this.delay = 0;
        this.data = 0;
        this.tiempo = 0;
        this.tipo = none;
    endfunction

    function print(string tag = "");
        $display(
                    "[%g] %s Tiempo=%g Tipo=%s Retardo=%g dato=0x%h",
                    $time,
                    tag,
                    tiempo,
                    this.tipo,
                    this.delay,
                    this.data
                );
    endfunction

endclass //trans_ctrl

///////////////////////////////////////////////////////////////////////
// Interface: Esta es la interface que se conecta con el controlador //
///////////////////////////////////////////////////////////////////////

interface ctrl_if #(
    parameter bits = 1,
    parameter drvrs = 4, 
    parameter pckg_sz = 16
) (
    input clk
);
    logic               reset,
    logic               pndng   [bits-1:0][drvrs-1:0],
    logic               push    [bits-1:0][drvrs-1:0],
    logic               pop     [bits-1:0][drvrs-1:0],
    logic [pckg_sz-1:0] D_pop   [bits-1:0][drvrs-1:0],
    logic [pckg_sz-1:0] D_push  [bits-1:0][drvrs-1:0]

endinterface

///////////////////////////////////////
//  Defino el mailbox                //
///////////////////////////////////////
typedef mailbox #(trans_ctrl) trans_ctrl_mbx;