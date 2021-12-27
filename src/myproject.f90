!> Main module file for the myproject library
module myproject
  use myproject_version, only : get_version
  implicit none

  private
  public :: get_version

end module myproject
