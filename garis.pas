program Garis;
uses graph,crt;
var    x1,y1,x2,y2 :byte;
Procedure init;
var
        gd,gm:integer;
begin
        gm:=detect;
        gd:=0;
        initgraph(gd,gm,'C:\TP\BGI');
        if graphresult <> grok then
        begin
                writeln('Membuka Graphic',gd,'graph mode',gm,'not supported');
                halt(1);
        end;
end;



Procedure drawline(xstart,ystart,xend,yend:integer);
var
        step,k:integer;
        dx,dy:real;
        x_inc,y_inc,x,y:real;
begin
        dx:=xend-xstart;
        dy:=yend-ystart;
        x:=xstart;
        y:=ystart;
        if abs(dx) > abs(dy) then
                step:=round(abs(dx))
        else
                step:=round(abs(dy));
        x_inc:=dx/step;
        y_inc:=dy/step;
        putpixel(round(x),round(y),30);
        for k:=1 to step do
        begin
                x:=x+x_inc;
                y:=y+y_inc;
                putpixel(round(x), round(y), 30);
        end;
end;
begin
        
        {menggambar garis dari titik 10,10 ke 500, 500}
        write('Masukkan X1');
        readln(x1);
        write('Masukkan Y1');
        readln(y1);
        write('Masukkan X2');
        readln(x2);
        write('Masukkan Y2');
        readln(y2);
        init;
        drawline(x1,y1,x2,y2);
        readkey;
end.