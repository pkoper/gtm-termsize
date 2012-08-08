
;  TermSize
;  Copyright (C) 2012 Piotr Koper <piotr.koper@gmail.com>
;
;  This program is free software: you can redistribute it and/or modify
;  it under the terms of the GNU Affero General Public License as
;  published by the Free Software Foundation, either version 3 of the
;  License, or (at your option) any later version.
;
;  This program is distributed in the hope that it will be useful,
;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;  GNU Affero General Public License for more details.
;
;  You should have received a copy of the GNU Affero General Public License
;  along with this program.  If not, see <http://www.gnu.org/licenses/>.

termsize ; example
	n s
	d init,square
	f  r *s:1 q:s>-1  d update
	w #
	q

init
	d &termsize.init("termsize")	; pass the env name
	s termsize=$ztrnlnm("termsize")
	q

update
	q:$ztrnlnm("termsize")=termsize	; quit if no change
	s termsize=$ztrnlnm("termsize")
	u $p:(width=$p(termsize," ",1):leng=$p(termsize," ",2))
	d square
	q

dev	; get device width & height
	n x,i
	zsh "d":x
	s i="" f  s i=$o(x("D",i)) q:i=""  d:(x("D",i)[$p)
	. s dw=$p($p(x("D",i),"WIDTH=",2)," ",1),dh=$p($p(x("D",i),"LENG=",2)," ",1)
	q

square
	n dw,dh,i,j
	d dev
	w #
	f i=1:1:2 w !
	f i=1:1:dh-4 d
	. f j=1:1:dw-11 w ?5,"*"
	. w !
	q
