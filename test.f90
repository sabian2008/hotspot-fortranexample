PROGRAM HOTSPOT_TEST
    REAL, ALLOCATABLE    :: A(:,:), B(:,:), C(:,:)
    REAL, ALLOCATABLE    :: CO(:,:), CO1(:,:), CO2(:,:), CO3(:,:)
    REAL, PARAMETER      :: tol = 1e-5
    INTEGER              :: n, ios
    CHARACTER(len=6)     :: arg

    ! Check number of arguments
    IF (iargc() == 1) THEN
        CALL getarg(1, arg)
    ELSE
        WRITE(*,*) "Correct usage is hotspot-test n, where n is the size&
                   & of the vector"
        CALL EXIT(1)
    END IF

    ! Convert to string to integer while performing error-checking
    READ(arg,'(i6)', iostat=ios) n
    
    IF (ios /= 0) THEN
        WRITE(*,*) "Argument must consist only of digits"
        CALL EXIT(2)
    ENDIF

    IF (n < 1) THEN
        WRITE(*,*) "Argument must be greater than 0"
        CALL EXIT(3)
    ENDIF

    ! Allocate arrays
    ALLOCATE (A(n,n), B(n,n), C(n,n), CO(n,n), CO1(n,n), CO2(n,n), CO3(n,n))

    ! Initialize arrays
    CALL RANDOM_NUMBER(A)
    CALL RANDOM_NUMBER(B)

    ! Compute
    CALL standard_mult(A, B, C, n)

    CALL multO(A, B, CO, n)
    CALL multO1(A, B, CO1, n)
    CALL multO2(A, B, CO2, n)
    CALL multO3(A, B, CO3, n)

    ! Error checking for calculations
    IF(ANY(ABS(CO - C) > tol)) THEN
        WRITE(*,*) "Something is wrong: CO does not match expected result"
        n = 0
    ENDIF

    IF(ANY(ABS(CO1 - C) > tol)) THEN
        WRITE(*,*) "Something is wrong: CO1 does not match expected result"
        n = 0
    ENDIF


    IF(ANY(ABS(CO2 - C) > tol)) THEN
        WRITE(*,*) "Something is wrong: CO2 does not match expected result"
        n = 0
    ENDIF

    IF(ANY(ABS(CO3 - C) > tol)) THEN
        WRITE(*,*) "Something is wrong: CO3 does not match expected result"
        n = 0
    ENDIF

    IF (n == 0) THEN
        CALL EXIT(4)
    ENDIF

    ! Close it up
    DEALLOCATE (A, B, C, CO, CO1, CO2, CO3)

END PROGRAM HOTSPOT_TEST
