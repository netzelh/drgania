program drgania
implicit none

real :: fx, fy, dt, fazax, fazay, N, Ax, Ay, X, Y, t
real, parameter :: pi=3.14159265353238
integer :: k, a
character (len=16) :: name,tytul
character :: b
character (len=80) :: sys


	write (*,'(a$)') 'Podaj częstości drgań X (w Hz): '
	read (*,*) fx
	write (*,'(a$)') 'Podaj częstości drgań Y (w Hz): '
	read (*,*) fy
	write (*,'(a$)') 'Podaj amplitudę X: '
	read (*,*) Ax
	write (*,'(a$)') 'Podaj amplitudę Y: '
	read (*,*) Ay
	write (*,'(a$)') 'Podaj fazę początkową X: '
	read (*,*) fazax
	write (*,'(a$)') 'Podaj fazę początkową Y: '
	read (*,*) fazay
	write (*,'(a$)') 'Podaj krok czasowy: '
	read (*,*) dt
	write (*,'(a$)') 'Podaj liczbę kroków: '
	read (*,*) N


	write (*,'(/a)') 'Ustawienia zapisy danych. Wybierz:'
	write (*,'(/a)') '1 - zapisywanie do pliku, tworzenie nowego pliku'
	write (*,'(/a)') '2 - zapisywanie do pliku, wybieranie istniejącego pliku'
	read (*,*) a

	

	if (a.eq.1) then
		write (*,'(a$)') 'Podaj nazwę pliku: '
		read (*,*) name
		open (1, file=name, status='new')
	else if (a.eq.2) then
		write (*,'(a$)') 'Podaj nazwę pliku: '
		read (*,*) name
		open (1, file=name, status='old')
	else
		write (*,*) 'Blad'
		stop
	end if


t=0
k=0
do
		X=Ax*sin(2*pi*fx*t+fazax)
		Y=Ay*sin(2*pi*fy*t+fazay)
		write (1,'(2f8.4)') X, Y
		t=t+dt
		k=k+1
	if (k>N) exit
end do

write (*,'(a$)') 'Tworzenie wykresu. T - tak, N - nie: '
read (*,*) b
	if (b.eq.'t') then
		write (*,*) 'Podaj tytul wykresu: '
		read (*,*) tytul
		sys='gnuplot -p -e "set title '//''''//trim(tytul)//''''//'; plot '//''''//trim(name)//''''//'"'
		!write (*,*) sys
		call system(sys)
	end if



write (*,*) 'Gotowe!'

stop
end program drgania
