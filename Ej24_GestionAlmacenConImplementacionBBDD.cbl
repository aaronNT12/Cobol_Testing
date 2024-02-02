IDENTIFICATION DIVISION.
PROGRAM-ID. almacen.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-DATOS-ALMACEN OCCURS 100 TIMES INDEXED BY WS-INDEX.
   05 WS-PRODUCTO PIC X(20).
   05 WS-CANTIDAD PIC 9(5) VALUE ZEROS.
01 WS-CONTINUAR PIC X VALUE 'S'.
01 WS-OPCION PIC 9.
01 WS-TOTAL PIC 9(5) VALUE ZEROS.

PROCEDURE DIVISION.
ACTUALIZAR-ALMACEN.
    PERFORM UNTIL WS-CONTINUAR = 'N'
        DISPLAY "-----------------------------"
        DISPLAY "1. Introducir producto"
        DISPLAY "2. Mostrar productos"
        DISPLAY "3. Eliminar producto"
        DISPLAY "4. Buscar producto"
        DISPLAY "5. Calcular total del inventario"
        DISPLAY "6. Salir"
        DISPLAY "-----------------------------"
        DISPLAY "Elige una opción: "
        ACCEPT WS-OPCION
        EVALUATE WS-OPCION
            WHEN 1 PERFORM INTRODUCIR-PRODUCTO
            WHEN 2 PERFORM MOSTRAR-PRODUCTOS
            WHEN 3 PERFORM ELIMINAR-PRODUCTO
            WHEN 4 PERFORM BUSCAR-PRODUCTO
            WHEN 5 PERFORM CALCULAR-TOTAL
            WHEN 6 MOVE 'N' TO WS-CONTINUAR
            WHEN OTHER DISPLAY "Opción no válida"
        END-EVALUATE
    END-PERFORM
    STOP RUN.

INTRODUCIR-PRODUCTO.
    SET WS-INDEX UP BY 1
    DISPLAY "Introduce el nombre del producto: "
    ACCEPT WS-PRODUCTO(WS-INDEX)
    DISPLAY "Introduce la cantidad del producto: "
    ACCEPT WS-CANTIDAD(WS-INDEX) ON EXCEPTION
        DISPLAY "Entrada no válida. Por favor, introduce un número."
        MOVE ZEROS TO WS-CANTIDAD(WS-INDEX)
    END-ACCEPT
    IF WS-CANTIDAD(WS-INDEX) > 0
        DISPLAY "Producto: " WS-PRODUCTO(WS-INDEX)
        DISPLAY "Cantidad: " WS-CANTIDAD(WS-INDEX)
    ELSE
        DISPLAY "La cantidad debe ser mayor que cero."

MOSTRAR-PRODUCTOS.
    PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL WS-INDEX > 100
        DISPLAY "Producto: " WS-PRODUCTO(WS-INDEX)
        DISPLAY "Cantidad: " WS-CANTIDAD(WS-INDEX)
    END-PERFORM

ELIMINAR-PRODUCTO.
    DISPLAY "Introduce el nombre del producto a eliminar: "
    ACCEPT WS-PRODUCTO
    PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL WS-INDEX > 100
        IF WS-PRODUCTO(WS-INDEX) = WS-PRODUCTO
            MOVE SPACES TO WS-PRODUCTO(WS-INDEX)
            MOVE ZEROS TO WS-CANTIDAD(WS-INDEX)
        END-IF
    END-PERFORM

BUSCAR-PRODUCTO.
    DISPLAY "Introduce el nombre del producto a buscar: "
    ACCEPT WS-PRODUCTO
    PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL WS-INDEX > 100
        IF WS-PRODUCTO(WS-INDEX) = WS-PRODUCTO
            DISPLAY "Producto: " WS-PRODUCTO(WS-INDEX)
            DISPLAY "Cantidad: " WS-CANTIDAD(WS-INDEX)
        END-IF
    END-PERFORM

CALCULAR-TOTAL.
    PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL WS-INDEX > 100
        ADD WS-CANTIDAD(WS-INDEX) TO WS-TOTAL
    END-PERFORM
    DISPLAY "Total del inventario: " WS-TOTAL

	
ACTUALIZAR-BASE-DE-DATOS.
	EXEC SQL
		CONNECT TO mydatabase
	END EXEC
	
	EXEC SQL
		UPDATE almacen
		SET cantidad = :WS-CANTIDAD
		WHERE producto = :WS-PRODUCTO
	END-EXEC
	
	IF SQLCODE NOT = 0
		DISPLAY "Error en la consulta SQL: " SQLCODE
	END-IF
