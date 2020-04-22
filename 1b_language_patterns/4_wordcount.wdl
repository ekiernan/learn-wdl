version 1.0

import "wc.wdl" as WC

workflow WordCount {
  input {
    Array[File] files
  }

  scatter(f in files) {
    call Mapper {
      input: file1=f
    }
  }
  
  # TODO: Implement reducer-script
  output {
    Mapper.reduceCount
  }
}

task Mapper {
  input {
    File file1
  }

  # TODO: Implement mapper-script
  command {
    WC ${mapper-script}
  }

  output {
    Int count = read_int(stdout())
  }
}

task Reducer {
    Map[Int, String] map
    scatter(pair in map) {
        String value = pair.left
    }
    output {
        Map[Int, String] mapping = read_map(stdout())
    }
}