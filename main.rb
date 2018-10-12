class Nodo
	attr_accessor :valor, :hizq, :Hder 
	def initialize(valor)
		@valor = valor
		@hizq = nil
		@Hder = nil
	end
end

class Arboln
	def initialize()
		@raiz = nil
	end

	def mostrar(raiz = nil)
		if raiz == nil
			raiz = @raiz
		end
		if raiz != nil
    		puts raiz.valor
			if raiz.hizq != nil
				self.mostrar(raiz.hizq)
			end	
			if raiz.Hder != nil
				self.mostrar(raiz.Hder)
			end			
		end 	
	end

	def buscaAnterior(nodo, raiz = nil)
		if raiz == nil
			raiz = @raiz
		end
		if raiz != nil
			if raiz.hizq != nil and raiz.hizq == nodo
				return raiz
			end
      if raiz.Hder != nil and raiz.Hder == nodo
				return raiz
			end
			if raiz.hizq != nil
        res = self.buscaAnterior(nodo, raiz.hizq)
				if res != nil
          return res 
        end 
			end
			if raiz.Hder != nil
				res = self.buscaAnterior(nodo, raiz.Hder)
        if res != nil
          return res 
        end 
			end
		end
	end

  def mostrarInvertido(raiz = nil)
		if raiz == nil
			raiz = @raiz
		end
		if raiz != nil
			if raiz.hizq != nil
				self.mostrarInvertido(raiz.hizq)
			end	
			if raiz.Hder != nil
				self.mostrarInvertido(raiz.Hder)
			end			
			puts raiz.valor
		end 	
  end

	def mostrarHermano(nodo = nil)
		puts nodo.valor
		if nodo.Hder != nil
			self.mostrarHermano(nodo.Hder)
		end
	end

  def mostrarHDER (raiz=nil, mostrarH = true)
    if raiz == nil
      raiz = @raiz
		end
	  if raiz != nil
	    if mostrarH
	      self.mostrarHermano(raiz)
	    end
	    if raiz.hizq!=nil
	      self.mostrarHDER(raiz.hizq)
	    end
	    if raiz.Hder!=nil
	      self.mostrarHDER(raiz.Hder, false)
	    end
	  end
  end

	def buscar(valor, raiz = nil)
		if raiz == nil
			raiz = @raiz
		end
		if raiz != nil
			if raiz.valor == valor
				return raiz
			end
			if raiz.hizq != nil
				nodo = self.buscar(valor, raiz.hizq)
				if nodo != nil
					return nodo
				end 
			end	
			if raiz.Hder != nil
				return self.buscar(valor, raiz.Hder)
			end			
			return nil
		end 	
	end

	def insertar (valor, padre = nil, pos = nil)
		nuevo = Nodo.new(valor)		
		if @raiz == nil
			@raiz = nuevo
			return
		end
		npadre = self.buscar(padre)
		if npadre != nil
			nodo = npadre.hizq		
			if nodo == nil
				npadre.hizq = nuevo
				return	
			end
			i = 0
			while nodo.Hder != nil and (pos == nil or i < pos-1)
				nodo = nodo.Hder
				i = i + 1		
			end
			nuevo.Hder = nodo.Hder
			nodo.Hder = nuevo
		else
			print  "No existe", padre
			puts
		end
	end 

	def changeRaiz(raiz)
		if raiz.hizq != nil #si tiene hizq cambio los enlaces
			@raiz = raiz.hizq

			if @raiz.hizq != nil
				nodo = @raiz.hizq
				while nodo.Hder != nil
					nodo = nodo.Hder
				end
				nodo.Hder = @raiz.Hder
				@raiz.Hder = nil
			else #enlazo Hder a hizq
				@raiz.hizq = @raiz.Hder
				@raiz.Hder = nil
			end
		else
			@raiz = nil
		end
	end

  def eliminarPadre(valor, raiz = nil)
		if raiz == nil
			raiz = @raiz
		end
    if raiz != nil
      if @raiz.valor == valor # eliminar @raiz original
      	self.changeRaiz(raiz)
      	return
      elsif raiz.valor == valor
				info_ant = self.buscaAnterior(raiz)
      	if raiz.hizq != nil # el nodo a eliminar tiene hijo izquierdo
          hermano = raiz.Hder
          nodo = raiz.hizq
          info_ant.hizq == raiz ? info_ant.hizq = nodo : info_ant.Hder = nodo #se determina si el anterior es padre o hermano
          while nodo.Hder != nil
            nodo = nodo.Hder
          end
          nodo.Hder = hermano
        elsif raiz.Hder != nil # el nodo a eliminar no tiene hijo izquierdo pero si tiene hermano
          info_ant.hizq == raiz ? info_ant.hizq = raiz.Hder : info_ant.Hder = raiz.Hder
        else
          info_ant.hizq == raiz ? info_ant.hizq = nil : info_ant.Hder = nil 
        end
			else
				if raiz.hizq!=nil
					self.eliminarPadre(valor, raiz.hizq)
				end
				if raiz.Hder!=nil
					self.eliminarPadre(valor, raiz.Hder)
				end
      end
    end
	end
end

n = Arboln.new
n.insertar(1,nil,0)
n.insertar(2,1)
n.insertar(3,1)
n.insertar('A',1)
n.insertar(4,2)
n.insertar(5,2)
n.insertar(6,2)
n.insertar('B',4)

n.insertar(7,3)
n.insertar(8,3)

n.insertar(9,8)
n.insertar(10,8)
n.insertar(11,8)
n.mostrar()
puts "----------"
n.eliminarPadre(7)
puts "--------------"
n.mostrar()
