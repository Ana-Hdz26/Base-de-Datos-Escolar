USE ControlEscolar2_eq20;
SELECT Nombre, Apellido_Paterno, Apellido_Materno
FROM Persona
WHERE Tipo = 'Alumno';

SELECT P.Nombre, P.Apellido_Paterno, P.Apellido_Materno, A.Nombre AS Nombre_Asignatura
FROM Profesores AS Pr
JOIN Asignaturas AS A ON Pr.ID_Profesor = A.ID_Profesor
JOIN Persona AS P ON Pr.ID_Profesor = P.ID;

SELECT P.Nombre, P.Apellido_Paterno, P.Sexo
FROM Persona AS P
LEFT JOIN Profesores AS Pr ON P.ID = Pr.ID_Profesor
LEFT JOIN Asignaturas AS A ON Pr.ID_Profesor = A.ID_Profesor
WHERE P.Tipo = 'Profesor' AND A.ID_Profesor IS NULL
LIMIT 1;

SELECT COUNT(*) AS Total_Alumnos
FROM Persona
WHERE Tipo = 'Alumno';

SELECT P.ID AS ID_Alumno, CONCAT(P.Nombre, ' ', P.Apellido_Paterno, ' ', P.Apellido_Materno) AS Nombre_Completo_Alumno, 
       A.ID AS ID_Asignatura, A.Nombre AS Nombre_Asignatura
FROM Persona AS P
JOIN Inscripciones AS I ON P.ID = I.ID_Alumno
JOIN Asignaturas AS A ON I.ID_Asignatura = A.ID
WHERE P.Tipo = 'Alumno' AND CONCAT(P.Nombre, ' ', P.Apellido_Paterno, ' ', P.Apellido_Materno) = 'Ana Hernández Miranda';

SELECT A.Nombre AS Nombre_Asignatura, 
       CONCAT(P.Nombre, ' ', P.Apellido_Paterno, ' ', P.Apellido_Materno) AS Nombre_Completo_Profesor
FROM Asignaturas AS A
JOIN Profesores AS Pr ON A.ID_Profesor = Pr.ID_Profesor
JOIN Persona AS P ON Pr.ID_Profesor = P.ID;

SELECT P.ID AS ID_Alumno, CONCAT(P.Nombre, ' ', P.Apellido_Paterno, ' ', P.Apellido_Materno) AS Nombre_Completo_Alumno, 
       A.ID AS ID_Asignatura, A.Nombre AS Nombre_Asignatura
FROM Persona AS P
JOIN Inscripciones AS I ON P.ID = I.ID_Alumno
JOIN Asignaturas AS A ON I.ID_Asignatura = A.ID
WHERE P.Tipo = 'Alumno' AND A.ID = 43;


SHOW PROCEDURE STATUS LIKE 'ObtenerAsignaturasDeAlumno';
DELIMITER //
CREATE PROCEDURE ObtenerAlumnosDeAsignatura (IN id_asignatura INT)
BEGIN
    SELECT P.ID AS ID_Alumno, CONCAT(P.Nombre, ' ', P.Apellido_Paterno, ' ', P.Apellido_Materno) AS Nombre_Completo_Alumno, 
           A.ID AS ID_Asignatura, A.Nombre AS Nombre_Asignatura
    FROM Persona AS P
    JOIN Inscripciones AS I ON P.ID = I.ID_Alumno
    JOIN Asignaturas AS A ON I.ID_Asignatura = A.ID
    WHERE P.Tipo = 'Alumno' AND A.ID = id_asignatura;
END //
DELIMITER ;
CALL ObtenerAlumnosDeAsignatura(43);


DELIMITER //
CREATE PROCEDURE ObtenerAsignaturasDeAlumno (IN nombre_alumno VARCHAR(255))
BEGIN
    SELECT P.ID AS ID_Alumno, CONCAT(P.Nombre, ' ', P.Apellido_Paterno, ' ', P.Apellido_Materno) AS Nombre_Completo_Alumno, 
           A.ID AS ID_Asignatura, A.Nombre AS Nombre_Asignatura
    FROM Persona AS P
    JOIN Inscripciones AS I ON P.ID = I.ID_Alumno
    JOIN Asignaturas AS A ON I.ID_Asignatura = A.ID
    WHERE P.Tipo = 'Alumno' AND CONCAT(P.Nombre, ' ', P.Apellido_Paterno, ' ', P.Apellido_Materno) = nombre_alumno;
END //
DELIMITER ;
CALL ObtenerAsignaturasDeAlumno('Ana Hernández Miranda');

DROP VIEW IF EXISTS VistaAlumnos;
CREATE VIEW VistaAlumnos AS
SELECT DISTINCT P.ID AS ID_Alumno, CONCAT(P.Nombre, ' ', P.Apellido_Paterno, ' ', P.Apellido_Materno) AS Nombre_Completo_Alumno
FROM Persona AS P
JOIN Inscripciones AS I ON P.ID = I.ID_Alumno
JOIN Asignaturas AS A ON I.ID_Asignatura = A.ID
WHERE P.Tipo = 'Alumno';
SELECT * FROM VistaAlumnos;



