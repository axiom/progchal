puts $<.inject{|a,b| [a.to_i,0].max + [b.to_i,0].max}
