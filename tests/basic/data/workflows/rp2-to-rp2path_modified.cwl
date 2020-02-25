#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
label: A modified CWL Workflow
inputs:
  rulesfile: File
  bsourcefile: File
  sinkfile: File
  reverse: boolean
  max-steps: int?
  minDepth: boolean

outputs:
  compounds:
    type: File
    outputSource: rp2paths/compounds
  reactions:
    type: File
    outputSource: rp2paths/reactions
  sinks:
    type: File
    outputSource: rp2paths/sinks

steps:
  rp2:
    run: ../tools/RetroPath2/RetroPath2.cwl
    in:
      input.rulesfile: rulesfile
      input.sourcefile: bsourcefile
      input.sinkfile: sinkfile
      input.max-steps: max-steps
    out: [solutionfile]

  rp2paths:
    run: ../tools/rp2paths/rp2paths.cwl
    in:
      infile: rp2/solutionfile
      reverse: reverse
      minDepth: minDepth
    out: [compounds, reactions, sinks]
hints:
  dep:Dependencies:
    dependencies:
    - upstream: https://raw.githubusercontent.com/ibisba/RetroPath2-cwl/0.0.1/tools/RetroPath2.cwl
      installTo: ../tools/RetroPath2
    - upstream: https://raw.githubusercontent.com/ibisba/rp2paths-cwl/1.0.2-1/tools/rp2paths.cwl
      installTo: ../tools/rp2paths
$namespaces:
  dep: http://commonwl.org/cwldep#


