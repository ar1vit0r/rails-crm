module LeadsHelper
  # Full class names so Tailwind's scanner sees them. Same colors as the
  # dashboard's pipeline strip: a stage color means one thing everywhere.
  STAGE_BORDERS = {
    "new_lead" => "border-l-stage-new",
    "qualified" => "border-l-stage-qualified",
    "proposal" => "border-l-stage-proposal",
    "won" => "border-l-stage-won",
    "lost" => "border-l-stage-lost"
  }.freeze

  def stage_border(lead)
    STAGE_BORDERS.fetch(lead.status)
  end

  def stage_label(lead)
    lead.status.delete_suffix("_lead").humanize
  end

  # Three pips, filled up to the priority level; the label is for screen readers.
  def priority_pips(lead)
    level = Lead.priorities.fetch(lead.priority, 0)
    label = "#{Lead.priorities.key(level).humanize} priority"

    tag.span(class: "inline-flex items-center gap-1") do
      safe_join([
        tag.span(label, class: "sr-only"),
        *3.times.map { |i| tag.span(class: "h-2 w-2 rounded-full #{i <= level ? 'bg-bone' : 'bg-gray-600'}", aria: { hidden: true }) }
      ])
    end
  end
end
