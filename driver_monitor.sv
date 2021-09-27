class driver #(
    parameter bits = 1,
    parameter drvrs = 4, 
    parameter pckg_sz = 16
    );

    // Variables
    virtual ctrl_if #( .bits(bits), .drvrs(drvrs), .pckg_sz(pckg_sz) ) vif;
    trans_ctrl_mbx agnt_drv_mbx;
    trans_ctrl_mbx mon_chkr_mbx;
    int espera;

    task run();
        $display("[%g] El se inicializa el driver", $time);
        @(posedge vif.clk);
        vif.rst = 1;
        @(posedge vif.clk);
        forever begin
            trans_ctrl #(.width(width)) trans;
            vif.push = 0;
            vif.pop  = 0;
            vif.dato = 0;
            vif.rst  = 0;
            $display("[%g] El driver espera una transaccion", $time);
            espera = 0;
            @(posedge vif.clk);
            agnt_drv_mbx.get(trans);
            transaction.print("Driver: Transaccion recibida");
            $display("Transacciones pendientes en el mbx agnt_drv = %g",agnt_drv_mbx.num());

            while ( espera < transaction.delay ) begin
                @(posedge vif.clk);
                espera = espera + 1;
                vif.dato_in = transaction.dato;
            end

            case(transaction.tipo)
                none: begin
                    //
                end
                t_push: begin
                    //
                end
                t_pop: begin
                    //
                end
                t_pp: begin
                    //
                end
                default: begin
                    $display("[%g] Driver Error: la transacción recibida no tiene tipo valido",$time);
                    $finish;
                end
            endcase
        @(posedge vif.clk);
        end
    endtask
endclass //driver

class monitor;
    function new();
        
    endfunction //new()
endclass //monitor