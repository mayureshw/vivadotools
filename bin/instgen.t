$for( signame,sigtype in ig.signals() )\
    signal $(signame) : $(sigtype);
$endfor\
begin
$for( inst,module,generics,bindings in ig.insts() )\
$(inst) : $(module)
$if( generics )\
    generic map (
$(ig.bindingstr(generics))
        )
$endif\
    port map (
$(ig.bindingstr(bindings))
        );
$endfor\
-- ENDINSTGEN
