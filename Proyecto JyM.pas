program jovenes_y_memoria;

type
  docente=record
    dni:integer;
    nombre:string;
    apellido:string;
    email:string;
  end;
    
  proyecto=record
    codigo:integer;  {codigo unico de proyecto}
    titulo:string;
    coordinador:docente;
    cantAlumnos:integer;  {cantidad de alumnos que participan del proyecto}
    nombreEscuela:string;  {nombre de la escuela que presenta el proyecto}
    localidad:string;  {localidad a la que pertenece la escuela}
  end;

procedure leerDocente(var d: docente);
begin
  writeln('Ingrese el DNI del docente: ');
  readln(d.dni);
  writeln('Ingrese el nombre del docente: ');
  readln(d.nombre);  
  writeln('Ingrese el apellido del docente: ');
  readln(d.apellido);  
  writeln('Ingrese el email del docente: ');
  readln(d.email);  
end;

procedure leerProyecto(var p: proyecto);
begin
  writeln('Ingrese el codigo unico del proyecto: ');
  readln(p.codigo);
  if (p.codigo <> -1) then
  begin
    writeln('Ingrese el titulo del proyecto: ');
    readln(p.titulo);  
    leerDocente(p.coordinador);
    writeln('Ingrese la cantidad de alumnos que participan del proyecto: ');
    readln(p.cantAlumnos);  
    writeln('Ingrese el nombre de la escuela: ');
    readln(p.nombreEscuela);  
    writeln('Ingrese la localidad a la que pertenece la escuela: ');
    readln(p.localidad);   
    writeln('-------------------------');
  end;
end;

procedure dosMaximos (cantAlu: integer; escuela:string; var cantAluMax1, cantAluMax2: integer; var escuelaMax1, escuelaMax2:string);
begin
  if (cantAlu>cantAluMax1) then
  begin
    cantAluMax2:=cantAluMax1;
    escuelaMax2:=escuelaMax1;
    cantAluMax1:=cantAlu;
    escuelaMax1:=escuela;
  end
  else
    if (cantAlu>cantAluMax2) then
    begin
      cantAluMax2:=cantAlu;
      escuelaMax2:=escuela;
    end;
end;

function descomponerCod (codigo:integer):boolean;
var
 digito, pares, impares:integer;
begin
  pares:=0;
  impares:=0;
  while(codigo <>0) do
  begin
    digito:=(codigo MOD 10);
    if (digito MOD 2 = 0) then
      pares:=pares+1
    else
      impares:=impares+1;
    codigo:=(codigo DIV 10);
  end;
  descomponerCod:=(pares=impares);
end;

var
  p: proyecto;
  localidadActual:string;  {localidad que se esta analizando}
  escuelaActual:string;  {escuela que se esta analizando}
  cantTotal:integer; {contador de escuelas que participan de la covocatoria}
  cantParcial: integer; {contador de escuelas por localidad que participan de la convocatoria}
  cantAlu:integer; {cantidad de alumnos por escuela}
  cantAluMax1, cantAluMax2:integer;  {maxima cantidad de alumnos participantes por escuela (x2)}
  escuelaMax1, escuelaMax2:string;  {nombres de las dos escuelas con mayor cantidad de alumnos participantes}

begin
  cantTotal:=0;
  cantAluMax1:=-1;
  cantAluMax2:=-1;
  leerProyecto(p);
  
  while (p.codigo <> -1) do
  begin 
    localidadActual:=p.localidad;
    cantParcial:=0;
   
    while ((p.codigo <> -1) AND (p.localidad = localidadActual)) do     {Inicio proyectos de una misma localidad}
    begin
      escuelaActual:=p.nombreEscuela;
      cantAlu:=0;
      
      while ((p.codigo <> -1) AND (p.localidad = localidadActual) AND (p.nombreEscuela = escuelaActual)) do     {Inicio proyectos de una misma escuela}

      begin
      cantAlu:=cantAlu+p.cantAlumnos;
      if ((p.localidad='Daireaux') AND (descomponerCod(p.codigo))) then
        begin
        writeln('El proyecto ', p.titulo, ' de la localidad de Daireaux posee un codigo con igual cantidad de digitos pares e impares');
        writeln('-------------------------');
        end;
      leerProyecto(p);
      end;     {Fin proyectos de una misma escuela}
      
      dosMaximos(cantAlu, escuelaActual, cantAluMax1, cantAluMax2, escuelaMax1, escuelaMax2);  
      cantTotal:=cantTotal+1;
      cantParcial:=cantParcial+1;
    end;     {Fin proyectos de una misma localidad}
    
    writeln('La cantidad de escuelas en la localidad ', localidadActual, ' es: ', cantParcial);
    writeln('-------------------------');

  end;
  
  writeln('La cantidad total de escuelas que participan en la convocatoria 2020 es: ', cantTotal);
  writeln('Los nombres de las dos escuelas con mayor cantidad de alumnos participantes son: ', escuelaMax1, ' ', cantAluMax1, ' y ', escuelaMax2, ' ', cantAluMax2);
end.


