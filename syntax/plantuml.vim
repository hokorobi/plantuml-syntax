" Vim syntax file
" Language:     PlantUML
" Maintainer:   Anders Thøgersen <first name at bladre dot dk>
if exists('b:current_syntax')
  finish
endif

scriptencoding utf-8

if v:version < 600
  syntax clear
endif

let s:cpo_orig=&cpo
set cpo&vim

let b:current_syntax = 'plantuml'

syntax sync minlines=100

syntax match plantumlPreProc /\%(^@startuml\|^@enduml\)\|!\%(define|definelong|else|enddefinelong|endif|exit|if|ifdef|ifndef|include|pragma|undef\)\s*.*/ contains=plantumlDir
syntax region plantumlDir start=/\s\+/ms=s+1 end=/$/ contained

syntax keyword plantumlTypeKeyword abstract actor agent archimate artifact boundary card cloud component control
syntax keyword plantumlTypeKeyword database entity enum file folder frame node object package participant
syntax keyword plantumlTypeKeyword queue rectangle stack state storage usecase

syntax keyword plantumlClassKeyword class interface

syntax keyword plantumlKeyword activate again allow_mixing allowmixing also alt as autonumber bottom box break
syntax keyword plantumlKeyword caption center create critical deactivate destroy down else elseif end endif
syntax keyword plantumlKeyword endwhile footbox footer fork group header hide hnote if is kill left legend link
syntax keyword plantumlKeyword loop namespace newpage note of on opt order over package page par partition ref
syntax keyword plantumlKeyword repeat return right rnote rotate show skin skinparam start stop title top up
syntax keyword plantumlKeyword while
" Not in 'java - jar plantuml.jar - language' output
syntax keyword plantumlKeyword then detach sprite

syntax keyword plantumlCommentTODO XXX TODO FIXME NOTE contained
syntax match plantumlColor /#[0-9A-Fa-f]\{6\}\>/
syntax keyword plantumlColor APPLICATION AliceBlue AntiqueWhite Aqua Aquamarine Azure BUSINESS Beige Bisque
syntax keyword plantumlColor Black BlanchedAlmond Blue BlueViolet Brown BurlyWood CadetBlue Chartreuse
syntax keyword plantumlColor Chocolate Coral CornflowerBlue Cornsilk Crimson Cyan DarkBlue DarkCyan
syntax keyword plantumlColor DarkGoldenRod DarkGray DarkGreen DarkGrey DarkKhaki DarkMagenta DarkOliveGreen
syntax keyword plantumlColor DarkOrchid DarkRed DarkSalmon DarkSeaGreen DarkSlateBlue DarkSlateGray
syntax keyword plantumlColor DarkSlateGrey DarkTurquoise DarkViolet Darkorange DeepPink DeepSkyBlue DimGray
syntax keyword plantumlColor DimGrey DodgerBlue FireBrick FloralWhite ForestGreen Fuchsia Gainsboro
syntax keyword plantumlColor GhostWhite Gold GoldenRod Gray Green GreenYellow Grey HoneyDew HotPink
syntax keyword plantumlColor IMPLEMENTATION IndianRed Indigo Ivory Khaki Lavender LavenderBlush LawnGreen
syntax keyword plantumlColor LemonChiffon LightBlue LightCoral LightCyan LightGoldenRodYellow LightGray
syntax keyword plantumlColor LightGreen LightGrey LightPink LightSalmon LightSeaGreen LightSkyBlue
syntax keyword plantumlColor LightSlateGray LightSlateGrey LightSteelBlue LightYellow Lime LimeGreen Linen
syntax keyword plantumlColor MOTIVATION Magenta Maroon MediumAquaMarine MediumBlue MediumOrchid MediumPurple
syntax keyword plantumlColor MediumSeaGreen MediumSlateBlue MediumSpringGreen MediumTurquoise MediumVioletRed
syntax keyword plantumlColor MidnightBlue MintCream MistyRose Moccasin NavajoWhite Navy OldLace Olive
syntax keyword plantumlColor OliveDrab Orange OrangeRed Orchid PHYSICAL PaleGoldenRod PaleGreen PaleTurquoise
syntax keyword plantumlColor PaleVioletRed PapayaWhip PeachPuff Peru Pink Plum PowderBlue Purple Red
syntax keyword plantumlColor RosyBrown RoyalBlue STRATEGY SaddleBrown Salmon SandyBrown SeaGreen SeaShell
syntax keyword plantumlColor Sienna Silver SkyBlue SlateBlue SlateGray SlateGrey Snow SpringGreen SteelBlue
syntax keyword plantumlColor TECHNOLOGY Tan Teal Thistle Tomato Turquoise Violet Wheat White WhiteSmoke
syntax keyword plantumlColor Yellow YellowGreen

" Arrows
syntax match plantumlArrow /.\@=\([.-]\)\1\+\ze\s*\%(\w\|(\)/

syntax match plantumlClassRelationLR /\([-.]\)\1*\%(\w\{,5\}\1\+\)\?\%(|>\|>\|*\|o\|x\|#\|{\|+\|\^\)/ contains=plantumlArrowDirectedLine
syntax match plantumlClassRelationRL /\%(<|\|<\|*\|o\|x\|#\|}\|+\|\^\)\([-.]\)\1*\%(\w\{,5\}\1\+\)\?/ contains=plantumlArrowDirectedLine

syntax match plantumlArrowLR /\[\?\([-.]\)\1*\%(\w\{,5}\1\+\)\?\%(\[[^\]]\+\]\)\?\1*\(>\|\\\|\/\)\2\?[ox]\?\]\?\%(\[[^\]]*\]\)\?/ contains=plantumlText,plantumlArrowDirectedLine
syntax match plantumlArrowRL /\[\?[ox]\?\(<\|\\\|\/\)\1\?\([-.]\)\2*\%(\w\{,5}\2\+\)\?\]\?\%(\[[^\]]*\]\)\?/ contains=plantumlText,plantumlArrowDirectedLine
syntax match plantumlArrowBoth /[ox]\?\(<\|\\\|\/\)\1\?\([-.]\)\2*\%(\w\{,5}\2\+\)\?\(>\|\\\|\/\)\3\?[ox]\?/ contains=plantumlArrowDirectedLine
syntax region plantumlText oneline start=/\[/ms=s+1 end=/\]/me=s-1 contained

syntax match plantumlArrowDirectedLine /\([-.]\)\%(l\%[eft]\|r\%[ight]\|up\?\|d\%[own]\)\1/ contained

" Note
syntax region plantumlNoteMultiLine start=/\%(^\s*[rh]\?note\)\@<=\s\%([^:"]\+$\)\@=/ end=/^\%(\s*end \?[rh]\?note$\)\@=/ contains=plantumlSpecialString,plantumlNoteMultiLineStart,plantumlTag
syntax match plantumlNoteMultiLineStart /\%(^\s*[rh]\?note\)\@<=\s\%([^:]\+$\)/ contained contains=plantumlKeyword,plantumlColor,plantumlString,plantumlTag

" Class
syntax region plantumlClass start=/\%(\%(class\|interface\|object\)\s[^{]\+\)\@<=\zs{/ end=/^\s*}/ contains=plantumlClassArrows,
\                                                                                  plantumlClassKeyword,
\                                                                                  @plantumlClassOp,
\                                                                                  plantumlClassSeparator,
\                                                                                  plantumlComment

syntax match plantumlClassPublic      /^\s*+\s*\w\+/ contained
syntax match plantumlClassPrivate     /^\s*-\s*\w\+/ contained
syntax match plantumlClassProtected   /^\s*#\s*\w\+/ contained
syntax match plantumlClassPackPrivate /^\s*\~\s*\w\+/ contained
syntax match plantumlClassSeparator   /\([_=\-.]\)\{2}\%(.\+\1\{2}\)\?/ contained

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

syntax match plantumlTag /<\/\?[bisu]>/
syntax region plantumlTag start=/<img/ end=/>/
syntax region plantumlTag start=/<\/\?\%(font\|size\|color\|del\|strike\)/ end=/>/

" Labels with a colon
syntax match plantumlColonLine /\S\@<=\s*\zs:.\+$/ contains=plantumlSpecialString

" Stereotypes
syntax match plantumlStereotype /<<[^-.]\+>>/ contains=plantumlSpecialString

" Activity diagram
syntax match plantumlActivityThing /([^)]*)/
syntax match plantumlActivitySynch /===[^=]\+===/
syntax match plantumlActivityLabel /\%(^\%(#\S\+\)\?\)\@<=:\_[^;|<>/\]}]\+[;|<>/\]}]$/ contains=plantumlSpecialString

" Sequence diagram
syntax match plantumlSequenceDivider /^\s*==[^=]\+==\s*$/
syntax match plantumlSequenceSpace /^\s*|||\+\s*$/
syntax match plantumlSequenceSpace /^\s*||\d\+||\+\s*$/
syntax match plantumlSequenceDelay /^\.\{3}$/
syntax region plantumlText oneline matchgroup=plantumlSequenceDelay start=/^\.\{3}/ end=/\.\{3}$/

" Usecase diagram
syntax match plantumlUsecaseActor /:.\{-1,}:/ contains=plantumlSpecialString

" Component diagram
syntax match plantumlComponent /\[.\{-1,}\]/ contains=plantumlSpecialString

" Skinparam keywords
syntax case ignore
syntax keyword plantumlSkinparamKeyword ActivityBackgroundColor ActivityBarColor ActivityBorderColor
syntax keyword plantumlSkinparamKeyword ActivityBorderThickness ActivityDiamondBackgroundColor
syntax keyword plantumlSkinparamKeyword ActivityDiamondBorderColor ActivityDiamondFontColor ActivityDiamondFontName
syntax keyword plantumlSkinparamKeyword ActivityDiamondFontSize ActivityDiamondFontStyle ActivityEndColor
syntax keyword plantumlSkinparamKeyword ActivityFontColor ActivityFontName ActivityFontSize ActivityFontStyle
syntax keyword plantumlSkinparamKeyword ActivityStartColor ActorBackgroundColor ActorBorderColor ActorFontColor
syntax keyword plantumlSkinparamKeyword ActorFontName ActorFontSize ActorFontStyle ActorStereotypeFontColor
syntax keyword plantumlSkinparamKeyword ActorStereotypeFontName ActorStereotypeFontSize ActorStereotypeFontStyle
syntax keyword plantumlSkinparamKeyword AgentBackgroundColor AgentBorderColor AgentBorderThickness AgentFontColor
syntax keyword plantumlSkinparamKeyword AgentFontName AgentFontSize AgentFontStyle AgentStereotypeFontColor
syntax keyword plantumlSkinparamKeyword AgentStereotypeFontName AgentStereotypeFontSize AgentStereotypeFontStyle
syntax keyword plantumlSkinparamKeyword ArrowColor ArrowFontColor ArrowFontName ArrowFontSize ArrowFontStyle
syntax keyword plantumlSkinparamKeyword ArrowLollipopColor ArrowMessageAlignment ArrowThickness ArtifactBackgroundColor
syntax keyword plantumlSkinparamKeyword ArtifactBorderColor ArtifactFontColor ArtifactFontName ArtifactFontSize
syntax keyword plantumlSkinparamKeyword ArtifactFontStyle ArtifactStereotypeFontColor ArtifactStereotypeFontName
syntax keyword plantumlSkinparamKeyword ArtifactStereotypeFontSize ArtifactStereotypeFontStyle BackgroundColor
syntax keyword plantumlSkinparamKeyword BiddableBackgroundColor BiddableBorderColor BoundaryBackgroundColor
syntax keyword plantumlSkinparamKeyword BoundaryBorderColor BoundaryFontColor BoundaryFontName BoundaryFontSize
syntax keyword plantumlSkinparamKeyword BoundaryFontStyle BoundaryStereotypeFontColor BoundaryStereotypeFontName
syntax keyword plantumlSkinparamKeyword BoundaryStereotypeFontSize BoundaryStereotypeFontStyle BoxPadding
syntax keyword plantumlSkinparamKeyword CaptionFontColor CaptionFontName CaptionFontSize CaptionFontStyle
syntax keyword plantumlSkinparamKeyword CardBackgroundColor CardBorderColor CardBorderThickness CardFontColor
syntax keyword plantumlSkinparamKeyword CardFontName CardFontSize CardFontStyle CardStereotypeFontColor
syntax keyword plantumlSkinparamKeyword CardStereotypeFontName CardStereotypeFontSize CardStereotypeFontStyle
syntax keyword plantumlSkinparamKeyword CircledCharacterFontColor CircledCharacterFontName CircledCharacterFontSize
syntax keyword plantumlSkinparamKeyword CircledCharacterFontStyle CircledCharacterRadius ClassAttributeFontColor
syntax keyword plantumlSkinparamKeyword ClassAttributeFontName ClassAttributeFontSize ClassAttributeFontStyle
syntax keyword plantumlSkinparamKeyword ClassAttributeIconSize ClassBackgroundColor ClassBorderColor
syntax keyword plantumlSkinparamKeyword ClassBorderThickness ClassFontColor ClassFontName ClassFontSize ClassFontStyle
syntax keyword plantumlSkinparamKeyword ClassHeaderBackgroundColor ClassStereotypeFontColor ClassStereotypeFontName
syntax keyword plantumlSkinparamKeyword ClassStereotypeFontSize ClassStereotypeFontStyle CloudBackgroundColor
syntax keyword plantumlSkinparamKeyword CloudBorderColor CloudFontColor CloudFontName CloudFontSize CloudFontStyle
syntax keyword plantumlSkinparamKeyword CloudStereotypeFontColor CloudStereotypeFontName CloudStereotypeFontSize
syntax keyword plantumlSkinparamKeyword CloudStereotypeFontStyle CollectionsBackgroundColor CollectionsBorderColor
syntax keyword plantumlSkinparamKeyword ColorArrowSeparationSpace ComponentBackgroundColor ComponentBorderColor
syntax keyword plantumlSkinparamKeyword ComponentBorderThickness ComponentFontColor ComponentFontName ComponentFontSize
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
syntax keyword plantumlSkinparamKeyword DesignedBackgroundColor DesignedBorderColor DesignedDomainBorderThickness
syntax keyword plantumlSkinparamKeyword DesignedDomainFontColor DesignedDomainFontName DesignedDomainFontSize
syntax keyword plantumlSkinparamKeyword DesignedDomainFontStyle DesignedDomainStereotypeFontColor
syntax keyword plantumlSkinparamKeyword DesignedDomainStereotypeFontName DesignedDomainStereotypeFontSize
syntax keyword plantumlSkinparamKeyword DesignedDomainStereotypeFontStyle DiagramBorderColor DiagramBorderThickness
syntax keyword plantumlSkinparamKeyword DomainBackgroundColor DomainBorderColor DomainBorderThickness DomainFontColor
syntax keyword plantumlSkinparamKeyword DomainFontName DomainFontSize DomainFontStyle DomainStereotypeFontColor
syntax keyword plantumlSkinparamKeyword DomainStereotypeFontName DomainStereotypeFontSize DomainStereotypeFontStyle Dpi
syntax keyword plantumlSkinparamKeyword EntityBackgroundColor EntityBorderColor EntityFontColor EntityFontName
syntax keyword plantumlSkinparamKeyword EntityFontSize EntityFontStyle EntityStereotypeFontColor
syntax keyword plantumlSkinparamKeyword EntityStereotypeFontName EntityStereotypeFontSize EntityStereotypeFontStyle
syntax keyword plantumlSkinparamKeyword FileBackgroundColor FileBorderColor FileFontColor FileFontName FileFontSize
syntax keyword plantumlSkinparamKeyword FileFontStyle FileStereotypeFontColor FileStereotypeFontName
syntax keyword plantumlSkinparamKeyword FileStereotypeFontSize FileStereotypeFontStyle FolderBackgroundColor
syntax keyword plantumlSkinparamKeyword FolderBorderColor FolderFontColor FolderFontName FolderFontSize FolderFontStyle
syntax keyword plantumlSkinparamKeyword FolderStereotypeFontColor FolderStereotypeFontName FolderStereotypeFontSize
syntax keyword plantumlSkinparamKeyword FolderStereotypeFontStyle FooterFontColor FooterFontName FooterFontSize
syntax keyword plantumlSkinparamKeyword FooterFontStyle FrameBackgroundColor FrameBorderColor FrameFontColor
syntax keyword plantumlSkinparamKeyword FrameFontName FrameFontSize FrameFontStyle FrameStereotypeFontColor
syntax keyword plantumlSkinparamKeyword FrameStereotypeFontName FrameStereotypeFontSize FrameStereotypeFontStyle
syntax keyword plantumlSkinparamKeyword GenericDisplay Guillemet Handwritten HeaderFontColor HeaderFontName
syntax keyword plantumlSkinparamKeyword HeaderFontSize HeaderFontStyle HyperlinkColor HyperlinkUnderline
syntax keyword plantumlSkinparamKeyword IconIEMandatoryColor IconPackageBackgroundColor IconPackageColor
syntax keyword plantumlSkinparamKeyword IconPrivateBackgroundColor IconPrivateColor IconProtectedBackgroundColor
syntax keyword plantumlSkinparamKeyword IconProtectedColor IconPublicBackgroundColor IconPublicColor
syntax keyword plantumlSkinparamKeyword InterfaceBackgroundColor InterfaceBorderColor InterfaceFontColor
syntax keyword plantumlSkinparamKeyword InterfaceFontName InterfaceFontSize InterfaceFontStyle
syntax keyword plantumlSkinparamKeyword InterfaceStereotypeFontColor InterfaceStereotypeFontName
syntax keyword plantumlSkinparamKeyword InterfaceStereotypeFontSize InterfaceStereotypeFontStyle LegendBackgroundColor
syntax keyword plantumlSkinparamKeyword LegendBorderColor LegendBorderThickness LegendFontColor LegendFontName
syntax keyword plantumlSkinparamKeyword LegendFontSize LegendFontStyle LexicalBackgroundColor LexicalBorderColor
syntax keyword plantumlSkinparamKeyword Linetype MachineBackgroundColor MachineBorderColor MachineBorderThickness
syntax keyword plantumlSkinparamKeyword MachineFontColor MachineFontName MachineFontSize MachineFontStyle
syntax keyword plantumlSkinparamKeyword MachineStereotypeFontColor MachineStereotypeFontName MachineStereotypeFontSize
syntax keyword plantumlSkinparamKeyword MachineStereotypeFontStyle MaxAsciiMessageLength MaxMessageSize MinClassWidth
syntax keyword plantumlSkinparamKeyword Monochrome NodeBackgroundColor NodeBorderColor NodeFontColor NodeFontName
syntax keyword plantumlSkinparamKeyword NodeFontSize NodeFontStyle NodeStereotypeFontColor NodeStereotypeFontName
syntax keyword plantumlSkinparamKeyword NodeStereotypeFontSize NodeStereotypeFontStyle Nodesep NoteBackgroundColor
syntax keyword plantumlSkinparamKeyword NoteBorderColor NoteBorderThickness NoteFontColor NoteFontName NoteFontSize
syntax keyword plantumlSkinparamKeyword NoteFontStyle NoteShadowing NoteTextAlignment ObjectAttributeFontColor
syntax keyword plantumlSkinparamKeyword ObjectAttributeFontName ObjectAttributeFontSize ObjectAttributeFontStyle
syntax keyword plantumlSkinparamKeyword ObjectBackgroundColor ObjectBorderColor ObjectBorderThickness ObjectFontColor
syntax keyword plantumlSkinparamKeyword ObjectFontName ObjectFontSize ObjectFontStyle ObjectStereotypeFontColor
syntax keyword plantumlSkinparamKeyword ObjectStereotypeFontName ObjectStereotypeFontSize ObjectStereotypeFontStyle
syntax keyword plantumlSkinparamKeyword PackageBackgroundColor PackageBorderColor PackageBorderThickness
syntax keyword plantumlSkinparamKeyword PackageFontColor PackageFontName PackageFontSize PackageFontStyle
syntax keyword plantumlSkinparamKeyword PackageStereotypeFontColor PackageStereotypeFontName PackageStereotypeFontSize
syntax keyword plantumlSkinparamKeyword PackageStereotypeFontStyle PackageStyle PackageTitleAlignment Padding
syntax keyword plantumlSkinparamKeyword PageBorderColor PageExternalColor PageMargin ParticipantBackgroundColor
syntax keyword plantumlSkinparamKeyword ParticipantBorderColor ParticipantFontColor ParticipantFontName
syntax keyword plantumlSkinparamKeyword ParticipantFontSize ParticipantFontStyle ParticipantPadding
syntax keyword plantumlSkinparamKeyword PartitionBackgroundColor PartitionBorderColor PartitionBorderThickness
syntax keyword plantumlSkinparamKeyword PartitionFontColor PartitionFontName PartitionFontSize PartitionFontStyle
syntax keyword plantumlSkinparamKeyword PathHoverColor QueueBackgroundColor QueueBorderColor QueueFontColor
syntax keyword plantumlSkinparamKeyword QueueFontName QueueFontSize QueueFontStyle QueueStereotypeFontColor
syntax keyword plantumlSkinparamKeyword QueueStereotypeFontName QueueStereotypeFontSize QueueStereotypeFontStyle Ranksep
syntax keyword plantumlSkinparamKeyword RectangleBackgroundColor RectangleBorderColor RectangleBorderThickness
syntax keyword plantumlSkinparamKeyword RectangleFontColor RectangleFontName RectangleFontSize RectangleFontStyle
syntax keyword plantumlSkinparamKeyword RectangleStereotypeFontColor RectangleStereotypeFontName
syntax keyword plantumlSkinparamKeyword RectangleStereotypeFontSize RectangleStereotypeFontStyle
syntax keyword plantumlSkinparamKeyword RequirementBackgroundColor RequirementBorderColor RequirementBorderThickness
syntax keyword plantumlSkinparamKeyword RequirementFontColor RequirementFontName RequirementFontSize
syntax keyword plantumlSkinparamKeyword RequirementFontStyle RequirementStereotypeFontColor
syntax keyword plantumlSkinparamKeyword RequirementStereotypeFontName RequirementStereotypeFontSize
syntax keyword plantumlSkinparamKeyword RequirementStereotypeFontStyle ResponseMessageBelowArrow RoundCorner
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
syntax keyword plantumlSkinparamKeyword SequenceMessageAlignment SequenceMessageTextAlignment
syntax keyword plantumlSkinparamKeyword SequenceNewpageSeparatorColor SequenceParticipant
syntax keyword plantumlSkinparamKeyword SequenceParticipantBorderThickness SequenceReferenceAlignment
syntax keyword plantumlSkinparamKeyword SequenceReferenceBackgroundColor SequenceReferenceBorderColor
syntax keyword plantumlSkinparamKeyword SequenceReferenceBorderThickness SequenceReferenceFontColor
syntax keyword plantumlSkinparamKeyword SequenceReferenceFontName SequenceReferenceFontSize SequenceReferenceFontStyle
syntax keyword plantumlSkinparamKeyword SequenceReferenceHeaderBackgroundColor SequenceStereotypeFontColor
syntax keyword plantumlSkinparamKeyword SequenceStereotypeFontName SequenceStereotypeFontSize
syntax keyword plantumlSkinparamKeyword SequenceStereotypeFontStyle SequenceTitleFontColor SequenceTitleFontName
syntax keyword plantumlSkinparamKeyword SequenceTitleFontSize SequenceTitleFontStyle Shadowing StackBackgroundColor
syntax keyword plantumlSkinparamKeyword StackBorderColor StackFontColor StackFontName StackFontSize StackFontStyle
syntax keyword plantumlSkinparamKeyword StackStereotypeFontColor StackStereotypeFontName StackStereotypeFontSize
syntax keyword plantumlSkinparamKeyword StackStereotypeFontStyle StateAttributeFontColor StateAttributeFontName
syntax keyword plantumlSkinparamKeyword StateAttributeFontSize StateAttributeFontStyle StateBackgroundColor
syntax keyword plantumlSkinparamKeyword StateBorderColor StateEndColor StateFontColor StateFontName StateFontSize
syntax keyword plantumlSkinparamKeyword StateFontStyle StateStartColor StereotypeABackgroundColor StereotypeABorderColor
syntax keyword plantumlSkinparamKeyword StereotypeCBackgroundColor StereotypeCBorderColor StereotypeEBackgroundColor
syntax keyword plantumlSkinparamKeyword StereotypeEBorderColor StereotypeIBackgroundColor StereotypeIBorderColor
syntax keyword plantumlSkinparamKeyword StereotypeNBackgroundColor StereotypeNBorderColor StereotypePosition
syntax keyword plantumlSkinparamKeyword StorageBackgroundColor StorageBorderColor StorageFontColor StorageFontName
syntax keyword plantumlSkinparamKeyword StorageFontSize StorageFontStyle StorageStereotypeFontColor
syntax keyword plantumlSkinparamKeyword StorageStereotypeFontName StorageStereotypeFontSize StorageStereotypeFontStyle
syntax keyword plantumlSkinparamKeyword Style SvglinkTarget SwimlaneBorderColor SwimlaneBorderThickness
syntax keyword plantumlSkinparamKeyword SwimlaneTitleFontColor SwimlaneTitleFontName SwimlaneTitleFontSize
syntax keyword plantumlSkinparamKeyword SwimlaneTitleFontStyle SwimlaneWidth SwimlaneWrapTitleWidth TabSize
syntax keyword plantumlSkinparamKeyword TitleBackgroundColor TitleBorderColor TitleBorderRoundCorner
syntax keyword plantumlSkinparamKeyword TitleBorderThickness TitleFontColor TitleFontName TitleFontSize TitleFontStyle
syntax keyword plantumlSkinparamKeyword UsecaseBackgroundColor UsecaseBorderColor UsecaseBorderThickness
syntax keyword plantumlSkinparamKeyword UsecaseFontColor UsecaseFontName UsecaseFontSize UsecaseFontStyle
syntax keyword plantumlSkinparamKeyword UsecaseStereotypeFontColor UsecaseStereotypeFontName UsecaseStereotypeFontSize
syntax keyword plantumlSkinparamKeyword UsecaseStereotypeFontStyle WrapWidth



" Not in 'java - jar plantuml.jar - language' output
syntax keyword plantumlSkinparamKeyword activityArrowColor activityArrowFontColor activityArrowFontName
syntax keyword plantumlSkinparamKeyword activityArrowFontSize activityArrowFontStyle BarColor BorderColor BoxPadding
syntax keyword plantumlSkinparamKeyword CharacterFontColor CharacterFontName CharacterFontSize CharacterFontStyle
syntax keyword plantumlSkinparamKeyword CharacterRadius classArrowColor classArrowFontColor classArrowFontName
syntax keyword plantumlSkinparamKeyword classArrowFontSize classArrowFontStyle Color componentArrowColor
syntax keyword plantumlSkinparamKeyword componentArrowFontColor componentArrowFontName componentArrowFontSize
syntax keyword plantumlSkinparamKeyword componentArrowFontStyle componentInterfaceBackgroundColor
syntax keyword plantumlSkinparamKeyword componentInterfaceBorderColor DividerBackgroundColor DividerFontColor
syntax keyword plantumlSkinparamKeyword DividerFontName DividerFontSize DividerFontStyle EndColor FontColor FontName
syntax keyword plantumlSkinparamKeyword FontSize FontStyle GroupBackgroundColor GroupingFontColor GroupingFontName
syntax keyword plantumlSkinparamKeyword GroupingFontSize GroupingFontStyle GroupingHeaderFontColor
syntax keyword plantumlSkinparamKeyword GroupingHeaderFontName GroupingHeaderFontSize GroupingHeaderFontStyle
syntax keyword plantumlSkinparamKeyword LifeLineBackgroundColor LifeLineBorderColor ParticipantPadding
syntax keyword plantumlSkinparamKeyword sequenceActorBackgroundColor sequenceActorBorderColor sequenceActorFontColor
syntax keyword plantumlSkinparamKeyword sequenceActorFontName sequenceActorFontSize sequenceActorFontStyle
syntax keyword plantumlSkinparamKeyword sequenceArrowColor sequenceArrowFontColor sequenceArrowFontName
syntax keyword plantumlSkinparamKeyword sequenceArrowFontSize sequenceArrowFontStyle sequenceGroupingFontColor
syntax keyword plantumlSkinparamKeyword sequenceGroupingFontName sequenceGroupingFontSize sequenceGroupingFontStyle
syntax keyword plantumlSkinparamKeyword sequenceGroupingHeaderFontColor sequenceGroupingHeaderFontName
syntax keyword plantumlSkinparamKeyword sequenceGroupingHeaderFontSize sequenceGroupingHeaderFontStyle
syntax keyword plantumlSkinparamKeyword sequenceParticipantBackgroundColor sequenceParticipantBorderColor
syntax keyword plantumlSkinparamKeyword sequenceParticipantFontColor sequenceParticipantFontName
syntax keyword plantumlSkinparamKeyword sequenceParticipantFontSize sequenceParticipantFontStyle StartColor
syntax keyword plantumlSkinparamKeyword stateArrowColor stateArrowFontColor stateArrowFontName stateArrowFontSize
syntax keyword plantumlSkinparamKeyword stateArrowFontStyle StereotypeFontColor StereotypeFontName StereotypeFontSize
syntax keyword plantumlSkinparamKeyword StereotypeFontStyle usecaseActorBackgroundColor usecaseActorBorderColor
syntax keyword plantumlSkinparamKeyword usecaseActorFontColor usecaseActorFontName usecaseActorFontSize
syntax keyword plantumlSkinparamKeyword usecaseActorFontStyle usecaseActorStereotypeFontColor
syntax keyword plantumlSkinparamKeyword usecaseActorStereotypeFontName usecaseActorStereotypeFontSize
syntax keyword plantumlSkinparamKeyword usecaseActorStereotypeFontStyle usecaseArrowColor usecaseArrowFontColor
syntax keyword plantumlSkinparamKeyword usecaseArrowFontName usecaseArrowFontSize usecaseArrowFontStyle
syntax case match

" Highlight
highlight default link plantumlCommentTODO Todo
highlight default link plantumlKeyword Keyword
highlight default link plantumlClassKeyword Keyword
highlight default link plantumlTypeKeyword Type
highlight default link plantumlPreProc PreProc
highlight default link plantumlDir Constant
highlight default link plantumlColor Constant
highlight default link plantumlArrow Identifier
highlight default link plantumlArrowBoth Identifier
highlight default link plantumlArrowLR Identifier
highlight default link plantumlArrowRL Identifier
highlight default link plantumlArrowDirectedLine Identifier
highlight default link plantumlClassRelationLR Identifier
highlight default link plantumlClassRelationRL Identifier
highlight default link plantumlText Label
highlight default link plantumlClass Type
highlight default link plantumlClassPublic Structure
highlight default link plantumlClassPrivate Macro
highlight default link plantumlClassProtected Statement
highlight default link plantumlClassPackPrivate Function
highlight default link plantumlClassSeparator Comment
highlight default link plantumlComponent String
highlight default link plantumlSequenceDivider Comment
highlight default link plantumlSequenceSpace Comment
highlight default link plantumlSpecialString Identifier
highlight default link plantumlTag Identifier
highlight default link plantumlSequenceDelay Identifier
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
