scriptencoding utf-8
" Vim syntax file
" Language:     PlantUML
" Maintainer:   Anders Thøgersen <first name at bladre dot dk>
" Version:      0.2
"
if exists('b:current_syntax')
  finish
endif

if v:version < 600
  syntax clear
endif

let s:cpo_orig=&cpo
set cpo&vim

let b:current_syntax = 'plantuml'

syntax sync minlines=100

syntax match plantumlPreProc /\%(^@startuml\|^@enduml\)\|!\%(define|definelong|else|enddefinelong|endif|ifdef|ifndef|include|pragma|undef\)\s*.*/ contains=plantumlDir
syntax region plantumlDir start=/\s\+/ms=s+1 end=/$/ contained

syntax case ignore

syntax keyword plantumlTypeKeyword abstract actor agent artifact boundary card cloud component control
syntax keyword plantumlTypeKeyword database entity enum file folder frame node object package participant
syntax keyword plantumlTypeKeyword pipe queue rectangle state storage usecase
syntax keyword plantumlTypeKeyword rect
syntax keyword plantumlClassKeyword class interface
syntax keyword plantumlKeyword activate again also alt as autonumber bottom box break caption center create
syntax keyword plantumlKeyword critical deactivate destroy down else elseif end endif endwhile footbox footer
syntax keyword plantumlKeyword fork group header hide hnote if is kill left legend link loop namespace newpage
syntax keyword plantumlKeyword note of on opt over package page par partition ref repeat return right rnote
syntax keyword plantumlKeyword rotate show skin skinparam start stop title top up while
syntax keyword plantumlKeyword then detach

syntax keyword plantumlCommentTODO XXX TODO FIXME NOTE contained
syntax match plantumlColor /#[0-9A-Fa-f]\{6\}\>/

" Arrows - Differentiate between horizontal and vertical arrows
syntax match plantumlHorizontalArrow /\%([-\.]\%(|>\|>\|\*\|o\>\|\\\\\|\\\|\/\/\|\/\|\.\|-\)\|\%(<|\|<\|\*\|\<o\|\\\\\|\\\|\/\/\|\/\)[\.-]\)\%(\[[^\]]*\]\)\?/ contains=plantumlLabel
syntax match plantumlDirectedOrVerticalArrowLR /[-\.]\%(le\?f\?t\?\|ri\?g\?h\?t\?\|up\?\|do\?w\?n\?\)\?[-\.]\%(|>\|>>\|>\|\*\|o\>\|\\\\\|\\\|\/\/\|\/\|\.\|-\)\%(\[[^\]]*\]\)\?/ contains=plantumlLabel
syntax match plantumlDirectedOrVerticalArrowRL /\%(<|\|<<\|<\|\*\|\<o\|\\\\\|\\\|\/\/\|\/\)[-\.]\%(le\?f\?t\?\|ri\?g\?h\?t\?\|up\?\|do\?w\?n\?\)\?[-\.]\%(\[[^\]]*\]\)\?/ contains=plantumlLabel
syntax region plantumlLabel start=/\[/ms=s+1 end=/\]/me=s-1 contained

" Note
syntax region plantumlNoteMultiLine start=/\%(^\s*[rh]\?note\s[^:"]\+\)\@<=$/ end=/^\%(\s*end \?[rh]\?note$\)\@=/ contains=plantumlSpecialString

" Class
syntax region plantumlClass start=/\%(class\s[^{]\+\)\@<=\zs{/ end=/^\s*}/ contains=plantumlClassArrows,
\                                                                                  plantumlClassKeyword,
\                                                                                  @plantumlClassOp,
\                                                                                  plantumlClassSeparator,
\                                                                                  plantumlComment

syntax match plantumlClassPublic      /^\s*+\s*\w\+/ contained
syntax match plantumlClassPrivate     /^\s*-\s*\w\+/ contained
syntax match plantumlClassProtected   /^\s*#\s*\w\+/ contained
syntax match plantumlClassPackPrivate /^\s*\~\s*\w\+/ contained
syntax match plantumlClassSeparator   /__\%(.\+__\)\?\|==\%(.\+==\)\?\|--\%(.\+--\)\?\|\.\.\%(.\+\.\.\)\?/ contained

syntax cluster plantumlClassOp contains=plantumlClassPublic,
\                                       plantumlClassPrivate,
\                                       plantumlClassProtected,
\                                       plantumlClassPackPrivate

" Strings
syntax match plantumlSpecialString /\\n/ contained
syntax region plantumlString start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=plantumlSpecialString
syntax region plantumlString start=/'/ skip=/\\\\\|\\'/ end=/'/ contains=plantumlSpecialString
syntax match plantumlComment /'.*$/ contains=plantumlCommentTODO
syntax region plantumlMultilineComment start=/\/'/ end=/'\// contains=plantumlCommentTODO

" Labels with a colon
syntax match plantumlColonLine /\S\@<=\s*\zs:.\+$/ contains=plantumlSpecialString

" Stereotypes
syntax match plantumlStereotype /<<.\{-1,}>>/ contains=plantumlSpecialString

" Activity diagram
syntax match plantumlActivityThing /([^)]*)/
syntax match plantumlActivitySynch /===[^=]\+===/
syntax region plantumlActivityLabel start=/^\s*:/ms=s+1 end=/;$/me=s-1 contains=plantumlSpecialString

" Usecase diagram
syntax match plantumlUsecaseActor /:.\{-1,}:/ contains=plantumlSpecialString

" Sequence diagram
syntax match plantumlSequenceDivider /^\s*==[^=]\+==\s*$/
syntax match plantumlSequenceSpace /^\s*|||\+\s*$/
syntax match plantumlSequenceSpace /^\s*||\d\+||\+\s*$/

" Skinparam keywords
syntax keyword plantumlSkinparamKeyword ActivityBackgroundColor ActivityBarColor ActivityBorderColor
syntax keyword plantumlSkinparamKeyword ActivityBorderThickness ActivityDiamondBackgroundColor
syntax keyword plantumlSkinparamKeyword ActivityDiamondBorderColor ActivityDiamondFontColor ActivityDiamondFontName
syntax keyword plantumlSkinparamKeyword ActivityDiamondFontSize ActivityDiamondFontStyle ActivityEndColor
syntax keyword plantumlSkinparamKeyword ActivityFontColor ActivityFontName ActivityFontSize ActivityFontStyle
syntax keyword plantumlSkinparamKeyword ActivityStartColor ActorBackgroundColor ActorBorderColor ActorFontColor
syntax keyword plantumlSkinparamKeyword ActorFontName ActorFontSize ActorFontStyle ActorStereotypeFontColor
syntax keyword plantumlSkinparamKeyword ActorStereotypeFontName ActorStereotypeFontSize ActorStereotypeFontStyle
syntax keyword plantumlSkinparamKeyword AgentBackgroundColor AgentBorderColor AgentFontColor AgentFontName AgentFontSize
syntax keyword plantumlSkinparamKeyword AgentFontStyle AgentStereotypeFontColor AgentStereotypeFontName
syntax keyword plantumlSkinparamKeyword AgentStereotypeFontSize AgentStereotypeFontStyle ArrowColor ArrowFontColor
syntax keyword plantumlSkinparamKeyword ArrowFontName ArrowFontSize ArrowFontStyle ArtifactBackgroundColor
syntax keyword plantumlSkinparamKeyword ArtifactBorderColor ArtifactFontColor ArtifactFontName ArtifactFontSize
syntax keyword plantumlSkinparamKeyword ArtifactFontStyle ArtifactStereotypeFontColor ArtifactStereotypeFontName
syntax keyword plantumlSkinparamKeyword ArtifactStereotypeFontSize ArtifactStereotypeFontStyle BackgroundColor
syntax keyword plantumlSkinparamKeyword BoundaryBackgroundColor BoundaryBorderColor BoundaryFontColor BoundaryFontName
syntax keyword plantumlSkinparamKeyword BoundaryFontSize BoundaryFontStyle BoundaryStereotypeFontColor
syntax keyword plantumlSkinparamKeyword BoundaryStereotypeFontName BoundaryStereotypeFontSize
syntax keyword plantumlSkinparamKeyword BoundaryStereotypeFontStyle CaptionFontColor CaptionFontName CaptionFontSize
syntax keyword plantumlSkinparamKeyword CaptionFontStyle CircledCharacterFontColor CircledCharacterFontName
syntax keyword plantumlSkinparamKeyword CircledCharacterFontSize CircledCharacterFontStyle CircledCharacterRadius
syntax keyword plantumlSkinparamKeyword ClassAttributeFontColor ClassAttributeFontName ClassAttributeFontSize
syntax keyword plantumlSkinparamKeyword ClassAttributeFontStyle ClassAttributeIconSize ClassBackgroundColor
syntax keyword plantumlSkinparamKeyword ClassBorderColor ClassBorderThickness ClassFontColor ClassFontName ClassFontSize
syntax keyword plantumlSkinparamKeyword ClassFontStyle ClassHeaderBackgroundColor ClassStereotypeFontColor
syntax keyword plantumlSkinparamKeyword ClassStereotypeFontName ClassStereotypeFontSize ClassStereotypeFontStyle
syntax keyword plantumlSkinparamKeyword CloudBackgroundColor CloudBorderColor CloudFontColor CloudFontName CloudFontSize
syntax keyword plantumlSkinparamKeyword CloudFontStyle CloudStereotypeFontColor CloudStereotypeFontName
syntax keyword plantumlSkinparamKeyword CloudStereotypeFontSize CloudStereotypeFontStyle CollectionsBackgroundColor
syntax keyword plantumlSkinparamKeyword CollectionsBorderColor ColorArrowSeparationSpace ComponentBackgroundColor
syntax keyword plantumlSkinparamKeyword ComponentBorderColor ComponentFontColor ComponentFontName ComponentFontSize
syntax keyword plantumlSkinparamKeyword ComponentFontStyle ComponentStereotypeFontColor ComponentStereotypeFontName
syntax keyword plantumlSkinparamKeyword ComponentStereotypeFontSize ComponentStereotypeFontStyle ComponentStyle
syntax keyword plantumlSkinparamKeyword ConditionStyle ControlBackgroundColor ControlBorderColor ControlFontColor
syntax keyword plantumlSkinparamKeyword ControlFontName ControlFontSize ControlFontStyle ControlStereotypeFontColor
syntax keyword plantumlSkinparamKeyword ControlStereotypeFontName ControlStereotypeFontSize ControlStereotypeFontStyle
syntax keyword plantumlSkinparamKeyword DatabaseBackgroundColor DatabaseBorderColor DatabaseFontColor DatabaseFontName
syntax keyword plantumlSkinparamKeyword DatabaseFontSize DatabaseFontStyle DatabaseStereotypeFontColor
syntax keyword plantumlSkinparamKeyword DatabaseStereotypeFontName DatabaseStereotypeFontSize
syntax keyword plantumlSkinparamKeyword DatabaseStereotypeFontStyle DefaultFontColor DefaultFontName DefaultFontSize
syntax keyword plantumlSkinparamKeyword DefaultFontStyle DefaultMonospacedFontName DefaultTextAlignment
syntax keyword plantumlSkinparamKeyword DiagramBorderColor DiagramBorderThickness Dpi EntityBackgroundColor
syntax keyword plantumlSkinparamKeyword EntityBorderColor EntityFontColor EntityFontName EntityFontSize EntityFontStyle
syntax keyword plantumlSkinparamKeyword EntityStereotypeFontColor EntityStereotypeFontName EntityStereotypeFontSize
syntax keyword plantumlSkinparamKeyword EntityStereotypeFontStyle FileBackgroundColor FileBorderColor FileFontColor
syntax keyword plantumlSkinparamKeyword FileFontName FileFontSize FileFontStyle FileStereotypeFontColor
syntax keyword plantumlSkinparamKeyword FileStereotypeFontName FileStereotypeFontSize FileStereotypeFontStyle
syntax keyword plantumlSkinparamKeyword FolderBackgroundColor FolderBorderColor FolderFontColor FolderFontName
syntax keyword plantumlSkinparamKeyword FolderFontSize FolderFontStyle FolderStereotypeFontColor
syntax keyword plantumlSkinparamKeyword FolderStereotypeFontName FolderStereotypeFontSize FolderStereotypeFontStyle
syntax keyword plantumlSkinparamKeyword FooterFontColor FooterFontName FooterFontSize FooterFontStyle
syntax keyword plantumlSkinparamKeyword FrameBackgroundColor FrameBorderColor FrameFontColor FrameFontName FrameFontSize
syntax keyword plantumlSkinparamKeyword FrameFontStyle FrameStereotypeFontColor FrameStereotypeFontName
syntax keyword plantumlSkinparamKeyword FrameStereotypeFontSize FrameStereotypeFontStyle Guillemet Handwritten
syntax keyword plantumlSkinparamKeyword HeaderFontColor HeaderFontName HeaderFontSize HeaderFontStyle HyperlinkColor
syntax keyword plantumlSkinparamKeyword HyperlinkUnderline IconIEMandatoryColor IconPackageBackgroundColor
syntax keyword plantumlSkinparamKeyword IconPackageColor IconPrivateBackgroundColor IconPrivateColor
syntax keyword plantumlSkinparamKeyword IconProtectedBackgroundColor IconProtectedColor IconPublicBackgroundColor
syntax keyword plantumlSkinparamKeyword IconPublicColor InterfaceBackgroundColor InterfaceBorderColor InterfaceFontColor
syntax keyword plantumlSkinparamKeyword InterfaceFontName InterfaceFontSize InterfaceFontStyle
syntax keyword plantumlSkinparamKeyword InterfaceStereotypeFontColor InterfaceStereotypeFontName
syntax keyword plantumlSkinparamKeyword InterfaceStereotypeFontSize InterfaceStereotypeFontStyle LegendBackgroundColor
syntax keyword plantumlSkinparamKeyword LegendBorderColor LegendBorderThickness LegendFontColor LegendFontName
syntax keyword plantumlSkinparamKeyword LegendFontSize LegendFontStyle Linetype MaxAsciiMessageLength MaxMessageSize
syntax keyword plantumlSkinparamKeyword MinClassWidth Monochrome NodeBackgroundColor NodeBorderColor NodeFontColor
syntax keyword plantumlSkinparamKeyword NodeFontName NodeFontSize NodeFontStyle NodeStereotypeFontColor
syntax keyword plantumlSkinparamKeyword NodeStereotypeFontName NodeStereotypeFontSize NodeStereotypeFontStyle Nodesep
syntax keyword plantumlSkinparamKeyword NoteBackgroundColor NoteBorderColor NoteBorderThickness NoteFontColor
syntax keyword plantumlSkinparamKeyword NoteFontName NoteFontSize NoteFontStyle NoteShadowing ObjectAttributeFontColor
syntax keyword plantumlSkinparamKeyword ObjectAttributeFontName ObjectAttributeFontSize ObjectAttributeFontStyle
syntax keyword plantumlSkinparamKeyword ObjectBackgroundColor ObjectBorderColor ObjectBorderThickness ObjectFontColor
syntax keyword plantumlSkinparamKeyword ObjectFontName ObjectFontSize ObjectFontStyle ObjectStereotypeFontColor
syntax keyword plantumlSkinparamKeyword ObjectStereotypeFontName ObjectStereotypeFontSize ObjectStereotypeFontStyle
syntax keyword plantumlSkinparamKeyword PackageBackgroundColor PackageBorderColor PackageBorderThickness
syntax keyword plantumlSkinparamKeyword PackageFontColor PackageFontName PackageFontSize PackageFontStyle
syntax keyword plantumlSkinparamKeyword PackageStereotypeFontColor PackageStereotypeFontName PackageStereotypeFontSize
syntax keyword plantumlSkinparamKeyword PackageStereotypeFontStyle PackageStyle Padding ParticipantBackgroundColor
syntax keyword plantumlSkinparamKeyword ParticipantBorderColor ParticipantFontColor ParticipantFontName
syntax keyword plantumlSkinparamKeyword ParticipantFontSize ParticipantFontStyle PartitionBackgroundColor
syntax keyword plantumlSkinparamKeyword PartitionBorderColor PartitionBorderThickness PartitionFontColor
syntax keyword plantumlSkinparamKeyword PartitionFontName PartitionFontSize PartitionFontStyle PipeBackgroundColor
syntax keyword plantumlSkinparamKeyword PipeBorderColor PipeFontColor PipeFontName PipeFontSize PipeFontStyle
syntax keyword plantumlSkinparamKeyword PipeStereotypeFontColor PipeStereotypeFontName PipeStereotypeFontSize
syntax keyword plantumlSkinparamKeyword PipeStereotypeFontStyle QueueBackgroundColor QueueBorderColor QueueFontColor
syntax keyword plantumlSkinparamKeyword QueueFontName QueueFontSize QueueFontStyle QueueStereotypeFontColor
syntax keyword plantumlSkinparamKeyword QueueStereotypeFontName QueueStereotypeFontSize QueueStereotypeFontStyle Ranksep
syntax keyword plantumlSkinparamKeyword RectangleBackgroundColor RectangleBorderColor RectangleBorderThickness
syntax keyword plantumlSkinparamKeyword RectangleFontColor RectangleFontName RectangleFontSize RectangleFontStyle
syntax keyword plantumlSkinparamKeyword RectangleStereotypeFontColor RectangleStereotypeFontName
syntax keyword plantumlSkinparamKeyword RectangleStereotypeFontSize RectangleStereotypeFontStyle RoundCorner
syntax keyword plantumlSkinparamKeyword SameClassWidth SequenceActorBorderThickness SequenceArrowThickness
syntax keyword plantumlSkinparamKeyword SequenceBoxBackgroundColor SequenceBoxBorderColor SequenceBoxFontColor
syntax keyword plantumlSkinparamKeyword SequenceBoxFontName SequenceBoxFontSize SequenceBoxFontStyle
syntax keyword plantumlSkinparamKeyword SequenceDelayFontColor SequenceDelayFontName SequenceDelayFontSize
syntax keyword plantumlSkinparamKeyword SequenceDelayFontStyle SequenceDividerBackgroundColor SequenceDividerBorderColor
syntax keyword plantumlSkinparamKeyword SequenceDividerBorderThickness SequenceDividerFontColor SequenceDividerFontName
syntax keyword plantumlSkinparamKeyword SequenceDividerFontSize SequenceDividerFontStyle SequenceGroupBackgroundColor
syntax keyword plantumlSkinparamKeyword SequenceGroupBodyBackgroundColor SequenceGroupBorderColor
syntax keyword plantumlSkinparamKeyword SequenceGroupBorderThickness SequenceGroupFontColor SequenceGroupFontName
syntax keyword plantumlSkinparamKeyword SequenceGroupFontSize SequenceGroupFontStyle SequenceGroupHeaderFontColor
syntax keyword plantumlSkinparamKeyword SequenceGroupHeaderFontName SequenceGroupHeaderFontSize
syntax keyword plantumlSkinparamKeyword SequenceGroupHeaderFontStyle SequenceLifeLineBackgroundColor
syntax keyword plantumlSkinparamKeyword SequenceLifeLineBorderColor SequenceLifeLineBorderThickness
syntax keyword plantumlSkinparamKeyword SequenceNewpageSeparatorColor SequenceParticipant
syntax keyword plantumlSkinparamKeyword SequenceParticipantBorderThickness SequenceReferenceBackgroundColor
syntax keyword plantumlSkinparamKeyword SequenceReferenceBorderColor SequenceReferenceBorderThickness
syntax keyword plantumlSkinparamKeyword SequenceReferenceFontColor SequenceReferenceFontName SequenceReferenceFontSize
syntax keyword plantumlSkinparamKeyword SequenceReferenceFontStyle SequenceReferenceHeaderBackgroundColor
syntax keyword plantumlSkinparamKeyword SequenceStereotypeFontColor SequenceStereotypeFontName
syntax keyword plantumlSkinparamKeyword SequenceStereotypeFontSize SequenceStereotypeFontStyle SequenceTitleFontColor
syntax keyword plantumlSkinparamKeyword SequenceTitleFontName SequenceTitleFontSize SequenceTitleFontStyle Shadowing
syntax keyword plantumlSkinparamKeyword StateAttributeFontColor StateAttributeFontName StateAttributeFontSize
syntax keyword plantumlSkinparamKeyword StateAttributeFontStyle StateBackgroundColor StateBorderColor StateEndColor
syntax keyword plantumlSkinparamKeyword StateFontColor StateFontName StateFontSize StateFontStyle StateStartColor
syntax keyword plantumlSkinparamKeyword StereotypeABackgroundColor StereotypeCBackgroundColor StereotypeEBackgroundColor
syntax keyword plantumlSkinparamKeyword StereotypeIBackgroundColor StereotypeNBackgroundColor StereotypePosition
syntax keyword plantumlSkinparamKeyword StorageBackgroundColor StorageBorderColor StorageFontColor StorageFontName
syntax keyword plantumlSkinparamKeyword StorageFontSize StorageFontStyle StorageStereotypeFontColor
syntax keyword plantumlSkinparamKeyword StorageStereotypeFontName StorageStereotypeFontSize StorageStereotypeFontStyle
syntax keyword plantumlSkinparamKeyword Style SvglinkTarget SwimlaneBorderColor SwimlaneBorderThickness
syntax keyword plantumlSkinparamKeyword SwimlaneTitleFontColor SwimlaneTitleFontName SwimlaneTitleFontSize
syntax keyword plantumlSkinparamKeyword SwimlaneTitleFontStyle TabSize TitleBackgroundColor TitleBorderColor
syntax keyword plantumlSkinparamKeyword TitleBorderRoundCorner TitleBorderThickness TitleFontColor TitleFontName
syntax keyword plantumlSkinparamKeyword TitleFontSize TitleFontStyle UsecaseBackgroundColor UsecaseBorderColor
syntax keyword plantumlSkinparamKeyword UsecaseFontColor UsecaseFontName UsecaseFontSize UsecaseFontStyle
syntax keyword plantumlSkinparamKeyword UsecaseStereotypeFontColor UsecaseStereotypeFontName UsecaseStereotypeFontSize
syntax keyword plantumlSkinparamKeyword UsecaseStereotypeFontStyle

" Highlight
highlight default link plantumlCommentTODO Todo
highlight default link plantumlKeyword Keyword
highlight default link plantumlClassKeyword Keyword
highlight default link plantumlTypeKeyword Type
highlight default link plantumlPreProc PreProc
highlight default link plantumlDir Constant
highlight default link plantumlColor Constant
highlight default link plantumlHorizontalArrow Identifier
highlight default link plantumlDirectedOrVerticalArrowLR Identifier
highlight default link plantumlDirectedOrVerticalArrowRL Identifier
highlight default link plantumlLabel Special
highlight default link plantumlClass Type
highlight default link plantumlClassPublic Structure
highlight default link plantumlClassPrivate Macro
highlight default link plantumlClassProtected Statement
highlight default link plantumlClassPackPrivate Function
highlight default link plantumlClassSeparator Comment
highlight default link plantumlSequenceDivider Comment
highlight default link plantumlSequenceSpace Comment
highlight default link plantumlSpecialString Identifier
highlight default link plantumlString String
highlight default link plantumlComment Comment
highlight default link plantumlMultilineComment Comment
highlight default link plantumlColonLine String
highlight default link plantumlActivityThing Type
highlight default link plantumlActivitySynch Type
highlight default link plantumlActivityLabel String
highlight default link plantumlSkinparamKeyword Identifier
highlight default link plantumlNoteMultiLine String
highlight default link plantumlUsecaseActor String
highlight default link plantumlStereotype Type

let &cpo=s:cpo_orig
unlet s:cpo_orig
