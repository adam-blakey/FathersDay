!~!~!~!~!~!~!~!~!~!~!~!~!
!!! Fathers' Day 2021 !!!
!~!~!~!~!~!~!~!~!~!~!~!~!

!==========================!
!      FATHERSDAY2021      !
!                          !
! Sample driver file to    !
!  calculate a father's    !
!  favourite child, using  !
!  novel and revolutionary !
!  science.                !
!==========================!
program FathersDay2021
    implicit none

    character(len=50), dimension(:), allocatable :: childrenDetails_name
    character(len=50), dimension(:), allocatable :: childrenDetails_fact

    integer :: favourite_child

    interface
        integer function calculate_favourite_child(names, facts)
            character(len=50), dimension(:), allocatable :: names
            character(len=50), dimension(:), allocatable :: facts
        end function
    end interface

    allocate(childrenDetails_name(3))
    allocate(childrenDetails_fact(3))

    childrenDetails_name(1) = "Lauren Blakey"
    childrenDetails_name(2) = "Ben Blakey"
    childrenDetails_name(3) = "Adam Blakey"

    childrenDetails_fact(1) = " because she's better than Ben."
    childrenDetails_fact(2) = " because he's better than Lauren."
    childrenDetails_fact(3) = " because he can lick his elbow."

    favourite_child = calculate_favourite_child(childrenDetails_name, childrenDetails_fact)

    print *, "Your favourite child is ", trim(childrenDetails_name(favourite_child)) // trim(childrenDetails_fact(favourite_child))

    deallocate(childrenDetails_fact)
    deallocate(childrenDetails_name)
end program

!===========================!
! CALCULATE_FAVOURITE_CHILD !
!                           !
! Uses science* to          !
!  calculate the favourite  !
!  child given their name   !
!  and an interesting fact. !
!                           !
! *wholly depends on your   !
!  definition of science.   !
!===========================!
integer function calculate_favourite_child(names, facts)
    character(len=50), dimension(:), allocatable :: names
    character(len=50), dimension(:), allocatable :: facts

    child_loop: do calculate_favourite_child=1, size(names)
        if (names(calculate_favourite_child)(1:4) == "Adam") then
            exit child_loop
        end if
    end do child_loop
end function



